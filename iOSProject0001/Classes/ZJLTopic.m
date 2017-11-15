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
#import "ZJLUser.h"

@implementation ZJLTopic

static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

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

- (CGFloat)cellHeight{
    //性能优化
    if (_cellHeight) {
        return _cellHeight;
    }

    //1.头像
    _cellHeight = 70;
    
    //2.文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * ZJLMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    //CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
    _cellHeight += textSize.height + ZJLMargin;
    
    //3.中间的内容
    if (self.type != ZJLTopicTypeWord) {
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= [UIScreen mainScreen].bounds.size.height) { //将超长图片变为200
            contentH = 200;
            self.bigPicture = YES;
        }
        
        self.contentF = CGRectMake(ZJLMargin, _cellHeight, textMaxW, contentH);
        
        _cellHeight += contentH + ZJLMargin;
    }
    
    //4.最热评论
    if (self.top_cmt) {
        _cellHeight += 20;
        
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username, self.top_cmt.content];
        //CGSize topCmtContentSize = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + ZJLMargin;
        
        
    }
    
    //工具条
    _cellHeight += 35 + ZJLMargin;
    return _cellHeight;
}

@end
