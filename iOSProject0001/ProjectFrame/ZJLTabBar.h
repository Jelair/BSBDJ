//
//  ZJLTabBar.h
//  TransactionList
//
//  Created by NowOrNever on 12/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJLTabBar;
@protocol ZJLTabBarDelegate <NSObject>
@optional
- (void)tabbarRecordButtonClick:(ZJLTabBar *)tabbar;

@end

@interface ZJLTabBar : UITabBar
//设置ZJLTabBar的代理
@property (nonatomic, weak) id<ZJLTabBarDelegate> mDelegate;
@end
