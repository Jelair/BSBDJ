//
//  UITabBarItem+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 23/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "UIBarButtonItem+ZJLExtension.h"

@implementation UIBarButtonItem (ZJLExtension)
+ (instancetype)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}
@end
