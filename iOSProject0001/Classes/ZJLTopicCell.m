//
//  ZJLTopicCell.m
//  iOSProject0001
//
//  Created by NowOrNever on 10/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTopicCell.h"
#import <UIImageView+WebCache.h>

@implementation ZJLTopicCell

- (void)setMTopic:(ZJLTopic *)mTopic{
    _mTopic = mTopic;
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:mTopic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = mTopic.name;
    self.create_atLabel.text = mTopic.created_at;
    self.text_Label.text = mTopic.text;
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= ZJLMargin;
    frame.origin.y += ZJLMargin;
    
    [super setFrame:frame];
}

@end
