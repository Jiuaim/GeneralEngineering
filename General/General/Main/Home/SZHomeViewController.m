//
//  SZHomeViewController.m
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZHomeViewController.h"
#import "SZNavigationController.h"
@interface SZHomeViewController ()

@end

@implementation SZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
@end
