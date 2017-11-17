//
//  UIImageView+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 18/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "UIImageView+ZJLExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (ZJLExtension)

- (void)setHeader:(NSString *)url{
    [self setCircleHeader:url];
}

- (void)setCircleHeader:(NSString *)url{
    UIImage *placeholder = [UIImage circleImage:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            return;
        }
        
        self.image = [image circleImage];
    }];
}

- (void)setRectHeader:(NSString *)url{
    UIImage *placeholder = [UIImage imageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

@end
