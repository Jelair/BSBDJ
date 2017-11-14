//
//  ZJLTopic.m
//  iOSProject0001
//
//  Created by NowOrNever on 10/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLTopic.h"
#import <MJExtension.h>
#import "ZJLComment.h"

@implementation ZJLTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"top_cmt" : [ZJLComment class]};
}

+ (void)initialize{
    //第一次使用本类时调用
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar zjl_calendar];
}

- (NSString *)created_at{

    //设置日期格式
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createAdDate = [fmt_ dateFromString:_created_at];

    if (createAdDate.isThisYear) {//今年
        if (createAdDate.isToday) {//今天
            //当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:createAdDate toDate:nowDate options:0];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else{
                return @"刚刚";
            }
        }else if(createAdDate.isYesterday){//昨天
            fmt_.dateFormat = @"昨天 HH:mm:ss";
            return [fmt_ stringFromDate:createAdDate];
        }else{
            fmt_.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt_ stringFromDate:createAdDate];
        }
    }else{
        return _created_at;
    }
    
}



@end
