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
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = ZJLSmallMargin;
    self.imageView.height = self.height- 2 * ZJLSmallMargin;
    self.imageView.width = self.imageView.height;
    if (self.imageView.image != nil) {
        self.textLabel.x = self.imageView.x + self.imageView.width + ZJLMargin;
    }
    
}

@end
