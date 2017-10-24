//
//  ZJLTabBarController.m
//  TransactionList
//
//  Created by NowOrNever on 12/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTabBarController.h"
#import "ZJLNavigationController.h"
#import "ZJLTabBar.h"

#import "ZJLEssenceViewController.h"
#import "ZJLNewViewController.h"
#import "ZJLFollowViewController.h"
#import "ZJLMeViewController.h"

@interface ZJLTabBarController ()<ZJLTabBarDelegate>

@end

@implementation ZJLTabBarController

+ (void)initialize{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    //设置tabbarItem字体
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpAllChildVc];
    
    ZJLTabBar *tabbar = [[ZJLTabBar alloc] init];
    tabbar.mDelegate = self;
    [self setValue:tabbar forKey:@"tabBar"];
}

- (void)setUpAllChildVc{
    ZJLEssenceViewController *essence = [[ZJLEssenceViewController alloc] init];
    [self setUpOneChildVcWithVc:essence image:@"tabBar_essence" selectImage:@"tabBar_essence_click" title:@"精选"];
    
    ZJLNewViewController *newC = [[ZJLNewViewController alloc] init];
    [self setUpOneChildVcWithVc:newC image:@"tabBar_new" selectImage:@"tabBar_new_click" title:@"新帖"];
    
    ZJLFollowViewController *follow = [[ZJLFollowViewController alloc] init];
    [self setUpOneChildVcWithVc:follow image:@"tabBar_friendTrends" selectImage:@"tabBar_friendTrends_click" title:@"关注"];
    
    ZJLMeViewController *me = [[ZJLMeViewController alloc] init];
    [self setUpOneChildVcWithVc:me image:@"tabBar_me" selectImage:@"tabBar_me_click" title:@"我"];
}


/**
 添加子控制器

 @param vc 子控制器
 @param image 默认图片
 @param selectImage 选择图片
 @param title 标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)vc image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title{
    ZJLNavigationController *nav = [[ZJLNavigationController alloc] initWithRootViewController:vc];
    UIImage *mImage = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = mImage;
    UIImage *mSelectImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = mSelectImage;
    vc.tabBarItem.title = title;
    //vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

#pragma mark -- mDelegate
- (void)tabbarRecordButtonClick:(ZJLTabBar *)tabbar{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
