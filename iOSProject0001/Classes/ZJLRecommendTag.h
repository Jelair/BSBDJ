//
//  ZJLRecommendTag.h
//  iOSProject0001
//
//  Created by NowOrNever on 17/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJLRecommendTag : NSObject

//名字
@property (nonatomic, copy) NSString *theme_name;
//图片
@property (nonatomic, copy) NSString *image_list;
//订阅数
@property (nonatomic, assign) NSInteger sub_number;
@end
