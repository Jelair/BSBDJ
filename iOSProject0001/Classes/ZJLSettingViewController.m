//
//  ZJLSettingViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 30/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLSettingViewController.h"

@interface ZJLSettingViewController ()

@end

@implementation ZJLSettingViewController

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = ZJLCommonBg;
    
    [self getCacheSize];
}

- (void)getCacheSize{
    NSUInteger size = 0;
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    //NSString *dirpath = [cachePath stringByAppendingPathComponent:@"MP3"];
    //ZJLLog(@"%@",dirpath);
    
    NSFileManager *fmr = [NSFileManager defaultManager];
    NSArray *subpaths = [fmr subpathsAtPath:cachePath];
    for (NSString *subpath in subpaths) {
        NSString *fullPath = [cachePath stringByAppendingPathComponent:subpath];
        NSDictionary *attr = [fmr attributesOfItemAtPath:fullPath error:nil];
        size += [attr[NSFileSize] unsignedIntegerValue];
    }
    
    ZJLLog(@"%zd",size);
}

#pragma mark -- datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"清除缓存";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
@end
