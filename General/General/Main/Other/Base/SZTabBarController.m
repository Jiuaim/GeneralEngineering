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
#import <AVFoundation/AVFoundation.h>
#import "UIDevice+Device.h"


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

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
//        // 判断是否是模拟器
//        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
//            return NO;
//        }
//        
//        // 判断是否有摄像头
//        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
////            [self showInfo:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
//            return NO;
//        }
//        
//        // 判断是否有摄像头权限
//        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
////            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
//            return NO;
//        }
//        
//        // 开启麦克风权限
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
//            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
//                if (granted) {
//                    return YES;
//                }
//                else {
////                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
//                    return NO;
//                }
//            }];
//        }
//        
////        SZMeViewController *showTimeVc = [[SZMeViewController alloc] init];
////        [self presentViewController:showTimeVc animated:YES completion:nil];
//        return NO;
//    }
//    return YES;
//}


@end
