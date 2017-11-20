//
//  ZJLExtensionConfig.m
//  iOSProject0001
//
//  Created by NowOrNever on 16/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLExtensionConfig.h"
#import <MJExtension.h>
#import "ZJLTopic.h"
#import "ZJLComment.h"

@implementation ZJLExtensionConfig

+ (void)load{
    [ZJLTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [ZJLComment class]};
    }];
    
    [ZJLTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id",
                 @"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"large_image" : @"image1",
                 @"middle_image" : @"image2"};
    }];
}

@end
