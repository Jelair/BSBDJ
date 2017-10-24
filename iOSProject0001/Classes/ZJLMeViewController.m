//
//  ZJLMeViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLMeViewController.h"

@interface ZJLMeViewController ()

@end

@implementation ZJLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
}

@end
