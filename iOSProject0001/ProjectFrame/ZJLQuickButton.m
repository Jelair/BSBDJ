//
//  ZJLQuickButton.m
//  iOSProject0001
//
//  Created by NowOrNever on 27/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLQuickButton.h"

@implementation ZJLQuickButton

- (void)awakeFromNib{
    //[super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
