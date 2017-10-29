//
//  UITextField+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 29/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "UITextField+ZJLExtension.h"

static  NSString* const ZJLPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ZJLExtension)

- (UIColor *)placeholderColor{
    return [self valueForKeyPath:ZJLPlaceholderColorKey];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    NSString *oldString = self.placeholder;
    self.placeholder = @" "; //提前创建placeholderLabel，防止为空
    self.placeholder = oldString;
    if(placeholderColor == nil){
        placeholderColor = [UIColor grayColor];
    }
    [self setValue:placeholderColor forKeyPath:ZJLPlaceholderColorKey];
}

@end
