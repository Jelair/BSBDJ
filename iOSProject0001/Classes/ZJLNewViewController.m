//
//  ZJLNewViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLNewViewController.h"

@interface ZJLNewViewController ()

@end

@implementation ZJLNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ZJLCommonBg;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] selectImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(navleftbtn_click)];
}

- (void)navleftbtn_click{
    
}


@end
