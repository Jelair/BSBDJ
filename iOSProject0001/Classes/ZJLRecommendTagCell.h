//
//  ZJLRecommendTagCell.h
//  iOSProject0001
//
//  Created by NowOrNever on 17/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJLRecommendTag;

@interface ZJLRecommendTagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageaView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
 
@property (nonatomic, strong) ZJLRecommendTag *recommendTag;

@end
