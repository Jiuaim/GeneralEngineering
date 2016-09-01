//
//  SZTabBarController.m
//  General
//
//  Created by llbt on 16/9/1.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "SZTabBarController.h"
#import "SZNavigationController.h"
#import "SZHomeViewController.h"
#import "SZMeViewController.h"

@interface SZTabBarController ()

@end

@implementation SZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViewControllerClass:[SZHomeViewController class] title:@"首页" imageName:@"tabbar_home_default" selectImageName:@"tabbar_home_selected"];
    [self addViewControllerClass:[SZMeViewController class] title:@"我的" imageName:@"tabbar_me_default" selectImageName:@"tabbar_me_selected"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:UIColorFromRGB(0xea8010)} forState:UIControlStateSelected];
}

- (void)addViewControllerClass:(Class)class title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName {
    UIViewController *viewC = [[class alloc]init];
    SZNavigationController *navC = [[SZNavigationController alloc] initWithRootViewController:viewC];
    navC.tabBarItem.title = title;
    navC.tabBarItem.image = [UIImage imageNamed:imageName];
    navC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];// 显示实际图片
    viewC.navigationItem.title = title;
    [self addChildViewController:navC];
}

@end
