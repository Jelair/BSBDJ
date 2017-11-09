//
//  ZJLEssenceViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLEssenceViewController.h"
#import "ViewController.h"

#import "ZJLAllTableViewController.h"
#import "ZJLVideoTableViewController.h"
#import "ZJLMusicTableViewController.h"
#import "ZJLPictureTableViewController.h"
#import "ZJLWordTableViewController.h"

@interface ZJLEssenceViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIButton *selectedTitleButton;
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titleView;
@end

@implementation ZJLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupChildViewControllers];
    [self setupScrollView];
    [self setupTitleView];
    
    [self setChildView];
}

- (void)setupNav{
    self.view.backgroundColor = ZJLCommonBg;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] selectImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(navleftbtn_click)];
}

- (void)setupChildViewControllers{
    ZJLAllTableViewController *all = [[ZJLAllTableViewController alloc] init];
    [self addChildViewController:all];
    
    ZJLVideoTableViewController *video = [[ZJLVideoTableViewController alloc] init];
    [self addChildViewController:video];
    
    ZJLMusicTableViewController *music = [[ZJLMusicTableViewController alloc] init];
    [self addChildViewController:music];
    
    ZJLPictureTableViewController *picture = [[ZJLPictureTableViewController alloc] init];
    [self addChildViewController:picture];
    
    ZJLWordTableViewController *word = [[ZJLWordTableViewController alloc] init];
    [self addChildViewController:word];
}

- (void)setupScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    NSUInteger count = self.childViewControllers.count;
//    for (NSUInteger i = 0; i < count; i++) {
//        UITableView *childView = (UITableView *)self.childViewControllers[i].view;
//        childView.x = i * childView.width;
//        childView.y = 0;
//        childView.height = scrollView.height;
//        [scrollView addSubview:childView];
//        childView.contentInset = UIEdgeInsetsMake(64+35, 0, 49, 0);
//        childView.scrollIndicatorInsets = childView.contentInset;
//    }
    
    scrollView.contentSize = CGSizeMake(count * scrollView.width, 0);
}

- (void)setupTitleView{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    titleView.frame = CGRectMake(0, 64, self.view.width, 35);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titleView.width / count;
    CGFloat titleButtonH = titleView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [titleButton addTarget:self action:@selector(ttitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    UIButton *firstTitleButton = titleView.subviews.firstObject;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.height = 1;
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    [firstTitleButton.titleLabel sizeToFit];
    [self ttitleClick:firstTitleButton];
}

- (void)ttitleClick:(UIButton *)titleButton{
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}].width;
        self.indicatorView.centerX = titleButton.centerX;
    }];
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)navleftbtn_click{
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

- (void)setChildView{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    UIViewController *childVc = self.childViewControllers[index];
    
    //判断视图是否加载
    if (childVc.view.superview) {
        return;
    }
    
//    if (childVc.view.window) {
//        return;
//    }
//    
//    if ([childVc isViewLoaded]) {
//        return;
//    }
    
//    childVc.view.y = 0;
//    childVc.view.x = index * self.scrollView.width;
//    childVc.view.width = self.scrollView.width;
//    childVc.view.height = self.scrollView.height;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark scrollViewControllerDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = self.titleView.subviews[index];
    [self ttitleClick:button];
    
    [self setChildView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self setChildView];
}

@end
