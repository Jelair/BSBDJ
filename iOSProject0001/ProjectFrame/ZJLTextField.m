//
//  ZJLTextField.m
//  iOSProject0001
//
//  Created by NowOrNever on 29/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTextField.h"

@implementation ZJLTextField

- (void)awakeFromNib{
    self.tintColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor grayColor];
}

- (BOOL)becomeFirstResponder{
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}

@end
