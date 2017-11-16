//
//  ZJLVideoView.m
//  iOSProject0001
//
//  Created by NowOrNever on 15/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLVideoView.h"
#import "ZJLTopic.h"
#import <UIImageView+WebCache.h>

@implementation ZJLVideoView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setMTopic:(ZJLTopic *)mTopic{
    _mTopic = mTopic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.large_image]];
    
    NSInteger minute = mTopic.videotime / 60;
    NSInteger second = mTopic.videotime % 60;
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute, second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", mTopic.playcount];
}

@end
