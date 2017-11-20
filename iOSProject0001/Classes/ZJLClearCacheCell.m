//
//  ZJLClearCacheCell.m
//  iOSProject0001
//
//  Created by NowOrNever on 31/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLClearCacheCell.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#define CacheFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"custom"]
@implementation ZJLClearCacheCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCaches_action)]];
    }
    return self;
}

- (void)setUpCell{
    self.textLabel.text = @"清除缓存(正在计算大小...)";
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.accessoryView = loadingView;
    [loadingView startAnimating];
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        unsigned long long size = CacheFilePath.fileSize;
        size += [SDImageCache sharedImageCache].getSize;
        
        [NSThread sleepForTimeInterval:5];
        if (weakSelf == nil) {
            return;
        }
        ZJLLog(@"test");
        
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) {
            sizeText = [NSString stringWithFormat:@"清除缓存(%.2fGB)",size / pow(10,9)];
        }else if (size >= pow(10, 6)) {
            sizeText = [NSString stringWithFormat:@"清除缓存(%.2fMB)",size / pow(10,6)];
        }else if (size >= pow(10, 3)) {
            sizeText = [NSString stringWithFormat:@"清除缓存(%.2fKB)",size / pow(10,3)];
        }else{
            sizeText = [NSString stringWithFormat:@"清除缓存(%zdB)",size];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.textLabel.text = sizeText;
            weakSelf.accessoryView = nil;
            weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        });
    });
}

- (void)clearCaches_action{
    [SVProgressHUD showWithStatus:@"正在清除缓存"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSFileManager *fmr = [NSFileManager defaultManager];
            [fmr removeItemAtPath:CacheFilePath error:nil];
            [fmr createDirectoryAtPath:CacheFilePath withIntermediateDirectories:YES attributes:nil error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                self.textLabel.text = @"清除缓存(0B)";
            });
        });
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
