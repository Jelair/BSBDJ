//
//  UIImageView+ZJLExtension.h
//  iOSProject0001
//
//  Created by NowOrNever on 18/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZJLExtension)
//设置头像（默认圆形）
- (void)setHeader:(NSString *)url;
//设置圆形头像
- (void)setCircleHeader:(NSString *)url;
//设置方形头像
- (void)setRectHeader:(NSString *)url;
@end
