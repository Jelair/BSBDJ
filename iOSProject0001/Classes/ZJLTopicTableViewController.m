//
//  ZJLTopicTableViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 09/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTopicTableViewController.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "ZJLTopicCell.h"
#import "ZJLRefreshHeader.h"
#import "ZJLRefreshFooter.h"
#import "ZJLHTTPSessionManager.h"
#import "ZJLCommentViewController.h"

@interface ZJLTopicTableViewController ()

@property (nonatomic, strong) NSMutableArray<ZJLTopic *> *topics;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) ZJLHTTPSessionManager *manager;
@end

@implementation ZJLTopicTableViewController
static NSString * const ZJLTopicCellId = @"topic";

- (ZJLTopicType)type{
    return 0;
}

- (ZJLHTTPSessionManager *)manager{
    if(!_manager){
        _manager = [ZJLHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZJLCommonBg;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJLTopicCell class]) bundle:nil] forCellReuseIdentifier:ZJLTopicCellId];
    [self setupRefresh];
    
}

- (void)setupRefresh{
    
    self.tableView.mj_header = [ZJLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [ZJLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 数据加载
- (void)loadNewTopics{
    //取消全部任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    __weak typeof(self) weakSelf = self;
    [self.manager GET:ZJLCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        weakSelf.topics = [ZJLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics{
    //取消全部任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    __weak typeof(self) weakSelf = self;
    [self.manager GET:ZJLCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray<ZJLTopic *> * moretopics = [ZJLTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [weakSelf.topics addObjectsFromArray:moretopics];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJLTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJLTopicCellId];
    cell.mTopic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJLLog(@"%f",self.topics[indexPath.row].cellHeight);
    return self.topics[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJLCommentViewController *vc = [[ZJLCommentViewController alloc] init];
    vc.mTopic = self.topics[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
