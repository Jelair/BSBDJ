//
//  ZJLMeViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLMeViewController.h"
#import "ZJLSettingViewController.h"
#import "ZJLMeCell.h"
#import "ZJLMeFootview.h"


@interface ZJLMeViewController ()

@end

@implementation ZJLMeViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = ZJLMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(ZJLMargin-35, 0, 0, 0);

    self.tableView.tableFooterView = [[ZJLMeFootview alloc] init];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZJLCommonBg;
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *moonBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-sun-icon-click"] target:self action:@selector(moonBtn_click)];
    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] selectImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBtn_click)];
    self.navigationItem.rightBarButtonItems = @[settingBtn,moonBtn];
}

- (void)moonBtn_click{
    
}

- (void)settingBtn_click{
    ZJLSettingViewController *vc = [[ZJLSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"me";
    ZJLMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJLMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    }else{
        cell.textLabel.text = @"离线加载";
        cell.imageView.image = nil;
    }
    
    return cell;
}

@end
