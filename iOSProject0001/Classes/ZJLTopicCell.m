//
//  ZJLTopicCell.m
//  iOSProject0001
//
//  Created by NowOrNever on 10/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTopicCell.h"
#import <UIImageView+WebCache.h>
#import "ZJLComment.h"
#import "ZJLUser.h"

@implementation ZJLTopicCell

- (void)setMTopic:(ZJLTopic *)mTopic{
    _mTopic = mTopic;
    [self.profile_image sd_setImageWithURL:[NSURL URLWithString:mTopic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = mTopic.name;
    
    //时间设置
    self.create_atLabel.text = mTopic.created_at;
    self.text_Label.text = mTopic.text;
    
    [self setupButton:self.dingBtn number:self.mTopic.ding placeholder:@"顶"];
    [self setupButton:self.caiBtn number:self.mTopic.cai placeholder:@"踩"];
    [self setupButton:self.shareBtn number:self.mTopic.repost placeholder:@"分享"];
    [self setupButton:self.commentBtn number:self.mTopic.comment placeholder:@"评论"];
    
    //最热评论
    if (mTopic.top_cmt.count) {
        self.topCmtView.hidden = NO;
        ZJLComment *comment = mTopic.top_cmt.firstObject;
        
        NSString *username = comment.user.username;
        NSString *content = comment.content;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username, content];
    }else{
        self.topCmtView.hidden = YES;
    }
}

//设置cell按钮
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if(number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= ZJLMargin;
    frame.origin.y += ZJLMargin;
    
    [super setFrame:frame];
}

@end
