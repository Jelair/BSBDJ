//
//  ZJLSettingViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 30/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLSettingViewController.h"
#import "ZJLClearCacheCell.h"

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
    ZJLClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZJLClearCacheCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}
@end
