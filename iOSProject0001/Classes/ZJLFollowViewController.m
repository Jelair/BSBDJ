//
//  ZJLFollowViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLFollowViewController.h"
#import "ZJLRecommendViewController.h"
#import "ZJLLoginRegisterViewController.h"

@interface ZJLFollowViewController ()

@end

@implementation ZJLFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZJLCommonBg;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] selectImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(navleftbtn_click)];
}

- (void)navleftbtn_click{
    ZJLRecommendViewController *vc = [[ZJLRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginAndRegister:(id)sender {
    ZJLLoginRegisterViewController *vc = [[ZJLLoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
