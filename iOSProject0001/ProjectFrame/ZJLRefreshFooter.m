//
//  ZJLRefreshFooter.m
//  iOSProject0001
//
//  Created by NowOrNever on 10/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLRefreshFooter.h"

@implementation ZJLRefreshFooter

- (void)prepare{
    [super prepare];
    
    //刷新控件什么时候开始刷新
    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    //是否自动刷新
    self.automaticallyRefresh = NO;
}

@end
