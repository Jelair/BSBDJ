//
//  ZJLRecommendTagController.m
//  iOSProject0001
//
//  Created by NowOrNever on 17/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLRecommendTagController.h"
#import "ZJLRecommendTagCell.h"
#import "ZJLHTTPSessionManager.h"
#import "ZJLRecommendTag.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface ZJLRecommendTagController ()

//所有的标签数据
@property (nonatomic, strong) NSArray *recommendTags;
//请求管理者
@property (nonatomic, weak) ZJLHTTPSessionManager *manager;

@end

@implementation ZJLRecommendTagController

//lazy load
- (ZJLHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [ZJLHTTPSessionManager manager];
    }
    return _manager;
}

static NSString * const ZJLRecommendTagCellId = @"recommendTag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJLRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:ZJLRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = ZJLCommonBg;

    [self loadNewRecommendTags];
}

//加载标签数据
- (void)loadNewRecommendTags{
    [SVProgressHUD show];
    
    __weak typeof(self) weakSelf = self;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //发送请求
    [self.manager GET:ZJLCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.recommendTags = [ZJLRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //如果是取消任务，就直接返回
        if (error.code == NSURLErrorCancelled) {
            return;
        }
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙"];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    //取消网络请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.recommendTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZJLRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJLRecommendTagCellId forIndexPath:indexPath];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}



@end
