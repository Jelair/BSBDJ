//
//  ZJLPictureView.h
//  iOSProject0001
//
//  Created by NowOrNever on 15/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJLTopic;
@class DALabeledCircularProgressView;

@interface ZJLPictureView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@property (nonatomic, strong) ZJLTopic *mTopic;

@end
