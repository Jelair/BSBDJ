//
//  ZJLMeCell.m
//  iOSProject0001
//
//  Created by NowOrNever on 29/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLMeCell.h"

@implementation ZJLMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = ZJLSmallMargin;
    self.imageView.height = self.height- 2 * ZJLSmallMargin;
}

@end
