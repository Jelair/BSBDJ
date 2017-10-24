//
//  ZJLTabBar.m
//  TransactionList
//
//  Created by NowOrNever on 12/09/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTabBar.h"

#import "UIView+ZJLExtension.h"

@interface ZJLTabBar ()
@property (nonatomic, weak) UIButton *recordBtn;
@end

@implementation ZJLTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *recordBtn = [[UIButton alloc] init];
        [recordBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish"] forState:UIControlStateNormal];
        [recordBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click"] forState:UIControlStateHighlighted];
        [recordBtn addTarget:self action:@selector(recordBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        self.recordBtn = recordBtn;
        [self addSubview:recordBtn];
        
        //设置tabbar背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar_light"];
    }
    return self;
}

- (void)recordBtnDidClick{
    if ([self.delegate respondsToSelector:@selector(tabbarRecordButtonClick:)]) {
        [self.mDelegate tabbarRecordButtonClick:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.recordBtn.size = CGSizeMake(self.recordBtn.currentBackgroundImage.size.width, self.recordBtn.currentBackgroundImage.size.height);
    self.recordBtn.centerX = self.centerX;
    
    //调整发布按钮的中线点Y值
    self.recordBtn.centerY = self.height*0.5;
    
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.width = self.width / 5;
            btn.x = btn.width * btnIndex;
            btnIndex++;
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.recordBtn];
        
        if ([self.recordBtn pointInside:newP withEvent:event]) {
            return self.recordBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else{
        return [super hitTest:point withEvent:event];
    }
}

@end
