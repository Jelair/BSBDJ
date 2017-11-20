//
//  ZJLCommentViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 20/11/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLCommentViewController.h"

@interface ZJLCommentViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@end

@implementation ZJLCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBase];
}

- (void)setupBase{
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark -- Listener
- (void)keyBoardWillChangeFrame:(NSNotification *)note{
    //修改约束
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.bottomMargin.constant = screenH - keyboardY;
    //执行动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark -- <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
