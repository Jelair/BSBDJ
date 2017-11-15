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
@property (nonatomic, strong) ZJLComment *top_cmt;
//帖子类型
@property (nonatomic, assign) NSInteger type;
//图片真实宽度
@property (nonatomic, assign) CGFloat width;
//图片真实高度
@property (nonatomic, assign) CGFloat height;
//小图
@property (nonatomic, copy) NSString *small_image;
//大图
@property (nonatomic, copy) NSString *large_image;
//中图
@property (nonatomic, copy) NSString *middle_image;

@property (nonatomic, assign) BOOL is_gif;
//额外的属性
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect contentF;
//是否
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
@end
