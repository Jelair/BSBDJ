//
//  UITabBarItem+ZJLExtension.h
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZJLExtension)
+ (instancetype)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;
@end
