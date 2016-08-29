//
//  ViewController.m
//  General
//
//  Created by llbt on 16/8/25.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *viw = [UIView horizonSeperateViewWithArray:@[@"UIView",@"UIButton",@"UIImageView"] categorys:@[@10,@5,@10,@10] HVPortion:3/4.0];
    [self.view addSubview:viw];
    [viw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
    }];
}



@end
