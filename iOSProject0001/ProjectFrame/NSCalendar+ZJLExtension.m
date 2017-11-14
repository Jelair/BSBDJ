//
//  NSCalendar+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 14/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "NSCalendar+ZJLExtension.h"

@implementation NSCalendar (ZJLExtension)

+ (instancetype)zjl_calendar{
    //系统适配
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else{
        return [NSCalendar currentCalendar];
    }
}

@end
