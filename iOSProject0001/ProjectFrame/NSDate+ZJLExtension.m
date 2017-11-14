//
//  NSDate+ZJLExtension.m
//  iOSProject0001
//
//  Created by NowOrNever on 14/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "NSDate+ZJLExtension.h"

@implementation NSDate (ZJLExtension)


/**
 是否为今年

 @return boolvalue
 */
- (BOOL) isThisYear{
    //判断self是否为今年
    NSCalendar *calendar = [NSCalendar zjl_calendar];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return selfYear == nowYear;
}


/**
 判断是否为今天

 @return boolValue
 */
- (BOOL) isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    return [selfString isEqualToString:nowString];
}


/**
 判断是否为昨天

 @return boolValue
 */
- (BOOL) isYesterday{
   
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    NSCalendar *calendar = [NSCalendar zjl_calendar];
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
