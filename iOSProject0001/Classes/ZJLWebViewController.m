//
//  ZJLWebViewController.m
//  iOSProject0001
//
//  Created by NowOrNever on 30/10/2017.
//  Copyright © 2017 NowOrNever. All rights reserved.
//

#import "ZJLWebViewController.h"

@interface ZJLWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZJLWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

@end
