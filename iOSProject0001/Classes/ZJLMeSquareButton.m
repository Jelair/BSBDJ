//
//  ZJLMeSquareButton.m
//  iOSProject0001
//
//  Created by NowOrNever on 30/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLMeSquareButton.h"
#import <UIButton+WebCache.h>

@implementation ZJLMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.bottom;
}

- (void)setSquare:(ZJLMeSquare *)square{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}

@end
