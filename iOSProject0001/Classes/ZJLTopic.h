//
//  ZJLTopic.h
//  iOSProject0001
//
//  Created by NowOrNever on 10/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef enum {
//    ZJLTopicTypePicture = 10,
//    ZJLTopicTypeWord = 29,
//    ZJLTopicTypeVoice = 31,
//    ZJLTopicTypeVideo = 41
//}ZJLTopicType;

typedef NS_ENUM(NSUInteger, ZJLTopicType){
    ZJLTopicTypePicture = 10,
    ZJLTopicTypeWord = 29,
    ZJLTopicTypeVoice = 31,
    ZJLTopicTypeVideo = 41
};

@class ZJLComment;

@interface ZJLTopic : NSObject
//用户的名字
@property (nonatomic, copy) NSString *name;
//用户的头像
@property (nonatomic, copy) NSString *profile_image;
//帖子的文字内容
@property (nonatomic, copy) NSString *text;
//帖子审核通过的时间
@property (nonatomic, copy) NSString *created_at;
//顶数量
@property (nonatomic, assign) NSInteger ding;
//踩数量
@property (nonatomic, assign) NSInteger cai;
//转发、分享数量
@property (nonatomic, assign) NSInteger repost;
//评论数量
@property (nonatomic, assign) NSInteger comment;
//最热评论
@property (nonatomic, strong) NSArray<ZJLComment *> *top_cmt;
//帖子类型
@property (nonatomic, assign) NSInteger type;

@end
