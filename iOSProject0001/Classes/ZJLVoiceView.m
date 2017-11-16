//
//  ZJLVoiceView.m
//  iOSProject0001
//
//  Created by NowOrNever on 15/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLVoiceView.h"
#import "ZJLTopic.h"
#import <UIImageView+WebCache.h>

@implementation ZJLVoiceView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setMTopic:(ZJLTopic *)mTopic{
    _mTopic = mTopic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.large_image]];
    
    NSInteger minute = mTopic.voicetime / 60;
    NSInteger second = mTopic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute, second];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", mTopic.playcount];
}

@end
