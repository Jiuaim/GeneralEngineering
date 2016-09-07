//
//  UIViewController+Extension.m
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)


- (UIView *)scrollBaseViewController {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = kRandomColor;
    scrollView.alwaysBounceVertical = YES;
    scrollView.delegate = self;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.clipsToBounds = YES;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:contentView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(scrollView);
        make.bottom.equalTo(scrollView).offset(-10);
    }];
    
    return contentView;
}

- (UITableView *)tableViewController {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    return tableView;
}


@end
