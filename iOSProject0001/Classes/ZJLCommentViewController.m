//
//  ZJLCommentViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 20/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLCommentViewController.h"
#import "ZJLHTTPSessionManager.h"
#import "ZJLRefreshHeader.h"
#import "ZJLRefreshFooter.h"
#import "ZJLTopic.h"
#import "ZJLComment.h"
#import <MJExtension.h>

@interface ZJLCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (nonatomic, strong) ZJLHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<ZJLComment *> *hotestComments;
@property (nonatomic, strong) NSMutableArray<ZJLComment *> *latestComments;
@end

@implementation ZJLCommentViewController

static NSString * const ZJLCommentCellId = @"ZJLCommentCell";

- (ZJLHTTPSessionManager *)manager{
    if(!_manager){
        _manager = [ZJLHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBase];
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ZJLCommentCellId];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor redColor];
    headerView.height = 200;
    self.tableView.tableHeaderView = headerView;
    self.tableView.backgroundColor = ZJLCommonBg;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupBase{
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark -- Listener
- (void)keyBoardWillChangeFrame:(NSNotification *)note{
    //修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    //执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupRefresh{
    
    self.tableView.mj_header = [ZJLRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [ZJLRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

#pragma mark -- 数据加载
- (void)loadNewComments{
    //取消全部任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.mTopic.ID;
    params[@"hot"] = @1;

    __weak typeof(self) weakSelf = self;
    [self.manager GET:ZJLCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [weakSelf.tableView.mj_header endRefreshing];
            return;
        }
        weakSelf.latestComments = [ZJLComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.hotestComments = [ZJLComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];

        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments{
    //取消全部任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark -- <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hotestComments.count) {
        return 2;
    }else if (self.latestComments.count){
        return 1;
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }
    
    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZJLCommentCellId];
    cell.textLabel.text = @"评论数据";
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0 && self.hotestComments.count) {
        return @"最热评论";
    }
    
    return @"最新评论";
}

#pragma mark -- <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
