//
//  ZJLPictureView.m
//  iOSProject0001
//
//  Created by NowOrNever on 15/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLPictureView.h"
#import "ZJLTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <DALabeledCircularProgressView.h>


@implementation ZJLPictureView

- (void)awakeFromNib{
    [super awakeFromNib];
    //取消xib控件的自动拉伸问题
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.progressView.roundedCorners = 5;
}

- (void)setMTopic:(ZJLTopic *)mTopic{
    _mTopic = mTopic;
    
    //网络判断（真机放开）
//    AFNetworkReachabilityStatus statu = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
//    if (statu == AFNetworkReachabilityStatusReachableViaWWAN) { //手机自带网络
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.small_image]];
//    } else if (statu == AFNetworkReachabilityStatusReachableViaWiFi) { //WIFI
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.large_image]];
//    } else { // 网络有问题，清空当前显示的图片
//        self.imageView.image = nil;
//    }
    
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.large_image]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:mTopic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        self.progressView.hidden = NO;
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
    }];
    
    //gif
    //第一种判断方法： [mTopic.large_image.lowercaseString hasSuffix:@"gif"]
    //第二种判断方法： [mTopic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"]
    
    self.gifView.hidden = !mTopic.is_gif;
    self.seeBigButton.hidden = !mTopic.isBigPicture;
    if (mTopic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}
@end
