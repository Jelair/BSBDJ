//
//  UIImage+ZJLExtension.h
//  iOSProject0001
//
//  Created by NowOrNever on 18/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJLExtension)

/*返回圆形图片*/
- (instancetype)circleImage;
/*根据图片名返回圆形图片*/
+ (instancetype)circleImage:(NSString *)name;

@end
