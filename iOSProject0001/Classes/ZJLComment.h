//
//  ZJLComment.h
//  iOSProject0001
//
//  Created by NowOrNever on 14/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZJLUser;

@interface ZJLComment : NSObject

//内容
@property (nonatomic, copy) NSString *content;
//用户（发表评论的人）
@property (nonatomic, strong) ZJLUser *user;

@end
