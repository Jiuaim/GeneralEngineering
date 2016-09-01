//
//  SZNavigationController.m
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZNavigationController.h"

@interface SZNavigationController () <UINavigationControllerDelegate>

@end

@implementation SZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0xea8010),NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [self backItem];
    }
}



- (UIBarButtonItem *)backItem {
    WEAK(self)
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navi_back"]];
    backImage.userInteractionEnabled = YES;
    backImage.frame = CGRectMake(0, 0, 32, 32);
    UITapGestureRecognizer *tap = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [weakself popViewControllerAnimated:YES];
    }];
    [backImage addGestureRecognizer:tap];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backImage];
    return back;
}

@end
