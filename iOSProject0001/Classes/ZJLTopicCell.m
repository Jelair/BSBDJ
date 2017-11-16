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
#import "ZJLPictureView.h"
#import "ZJLVideoView.h"
#import "ZJLVoiceView.h"

@interface ZJLTopicCell ()
@property (nonatomic, weak) ZJLPictureView *pictureView;
@property (nonatomic, weak) ZJLVoiceView *voiceView;
@property (nonatomic, weak) ZJLVideoView *videoView;
@end

@implementation ZJLTopicCell

#pragma mark -- lazy load
- (ZJLPictureView *)pictureView{
    if (!_pictureView) {
        _pictureView = [ZJLPictureView zjl_viewFromXib];
        [self.contentView addSubview:_pictureView];
    }
    return _pictureView;
}

- (ZJLVoiceView *)voiceView{
    if (!_voiceView) {
        _voiceView = [ZJLVoiceView zjl_viewFromXib];
        [self.contentView addSubview:_voiceView];
    }
    return _voiceView;
}

- (ZJLVideoView *)videoView{
    if (!_videoView) {
        _videoView = [ZJLVideoView zjl_viewFromXib];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
}


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
    if (mTopic.top_cmt) {
        self.topCmtView.hidden = NO;
        ZJLComment *comment = mTopic.top_cmt;
        
        NSString *username = comment.user.username;
        NSString *content = comment.content;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",username, content];
    }else{
        self.topCmtView.hidden = YES;
    }
    
    //中间内容
    if(mTopic.type == ZJLTopicTypeVideo){
        self.videoView.hidden = NO;
        self.videoView.mTopic = mTopic;
        self.videoView.frame = mTopic.contentF;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if(mTopic.type == ZJLTopicTypeVoice){
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        self.voiceView.mTopic = mTopic;
        self.voiceView.frame = mTopic.contentF;
        self.pictureView.hidden = YES;
    } else if(mTopic.type == ZJLTopicTypePicture){
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = NO;
        self.pictureView.mTopic = mTopic;
        self.pictureView.frame = mTopic.contentF;
    } else if(mTopic.type == ZJLTopicTypeWord){
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
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
