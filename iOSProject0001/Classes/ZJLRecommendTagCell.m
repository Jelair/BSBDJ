//
//  ZJLRecommendTagCell.m
//  iOSProject0001
//
//  Created by NowOrNever on 17/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLRecommendTagCell.h"
#import "ZJLRecommendTag.h"
#import <UIImageView+WebCache.h>

@implementation ZJLRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(ZJLRecommendTag *)recommendTag{
    _recommendTag = recommendTag;
    //头像
    [self.imageaView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    //名字
    self.name.text = recommendTag.theme_name;
    
    //订阅数
    if (recommendTag.sub_number >= 10000) {
        self.numberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number / 10000.0];
    } else{
        self.numberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
}

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
