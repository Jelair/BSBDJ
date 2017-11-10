//
//  ZJLMeFootview.m
//  iOSProject0001
//
//  Created by NowOrNever on 29/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLMeFootview.h"
#import "ZJLMeSquare.h"
#import "ZJLHTTPSessionManager.h"
#import <MJExtension.h>

#import "ZJLMeSquareButton.h"
#import "ZJLWebViewController.h"
@implementation ZJLMeFootview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        [[ZJLHTTPSessionManager manager] GET:ZJLCommonURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //ZJLLog(@"%@",responseObject);
            //[responseObject writeToFile:@"/Users/nowornever/Desktop/me.plist" atomically:YES];
            NSArray *squares = [ZJLMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
    return self;
}

- (void)createSquares:(NSArray *)squares{
    NSUInteger count = squares.count;
    int maxColsCount = 4;
    CGFloat squareW = self.width / maxColsCount;
    CGFloat squareH = squareW;
    for (int i = 0; i < count; i++) {
        
        ZJLMeSquareButton *button = [ZJLMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button.x = (i % maxColsCount) * squareW;
        button.y = (i / maxColsCount) * squareH;
        button.width = squareW;
        button.height = squareH;
        
        button.square = squares[i];
    }
    
    self.height = self.subviews.lastObject.y + self.subviews.lastObject.height;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];
//    tableView.contentSize = CGSizeMake(0, self.height+self.y); 不靠谱
}

- (void)buttonClick:(ZJLMeSquareButton *)button{
    ZJLMeSquare *square = button.square;
    NSString *url = square.url;
    if ([url hasPrefix:@"http"]) {
        ZJLWebViewController *vc = [[ZJLWebViewController alloc] init];
        vc.url = url;
        vc.navigationItem.title = square.name;
        UITabBarController *tabbar = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabbar.selectedViewController;
        [nav pushViewController:vc animated:YES];
        
    }else if([url hasPrefix:@"mod"]){
        ZJLLog(@"内部跳转");
    }
}

@end
