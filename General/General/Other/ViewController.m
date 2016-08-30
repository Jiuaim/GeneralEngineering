//
//  ViewController.m
//  General
//
//  Created by llbt on 16/8/25.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *contentView = [self scrollBaseViewController];
    UIView *viw = [UIView horizonSeperateViewWithArray:@[@"UIView",@"UIButton",@"UIImageView"] eventBlock:^(UIView *touchView) {
        NSLog(@"%@",NSStringFromClass([touchView class]));
    } categorys:@[@10,@5,@10,@10] HVPortion:3/4.0];
    UIView *viw1 = [UIView horizonSeperateViewWithArray:@[@"UIView",@"UIButton",@"UIImageView"] eventBlock:^(UIView *touchView) {
        NSLog(@"%@",NSStringFromClass([touchView class]));
    } categorys:@[@10,@5,@10,@10] HVPortion:3/4.0];
    UIView *viw2 = [UIView horizonSeperateViewWithArray:@[@"UIView",@"UIButton",@"UIImageView"] eventBlock:^(UIView *touchView) {
        NSLog(@"%@",NSStringFromClass([touchView class]));
    } categorys:@[@10,@5,@10,@10] HVPortion:3/4.0];
    [contentView addSubviewsWithVerticalLayout:@[viw,viw1,viw2] offsets:@[@10,@200,@300]];
    
    
}


@end
