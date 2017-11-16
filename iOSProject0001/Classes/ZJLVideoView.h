//
//  ZJLVideoView.h
//  iOSProject0001
//
//  Created by NowOrNever on 15/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJLTopic;

@interface ZJLVideoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (nonatomic, strong) ZJLTopic *mTopic;

@end
