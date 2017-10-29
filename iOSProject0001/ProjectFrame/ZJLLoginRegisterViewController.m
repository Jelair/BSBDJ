//
//  ZJLLoginRegisterViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 27/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLLoginRegisterViewController.h"

@interface ZJLLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargen;

@end

@implementation ZJLLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!sender.selected) {
        self.leftMargen.constant = -self.view.width;
    }else{
        self.leftMargen.constant = 0;
    }
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
