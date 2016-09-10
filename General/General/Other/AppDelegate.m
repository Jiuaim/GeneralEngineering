//
//  AppDelegate.m
//  General
//
//  Created by llbt on 16/8/25.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDatabase.h"
#import "SZNetworkTool.h"
#import "Reachability.h"
#import "SZLoginViewController.h"
#import "SZTabBarController.h"

@interface AppDelegate () {
    Reachability *_reacha;
    NetworkStates _preStatus;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 数据库
    self.database = [[AppDatabase alloc] initWithMigrations];
    NSLog(@"%@",NSHomeDirectory());
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    SZTabBarController *tabBar = [[SZTabBarController alloc] init];
    self.window.rootViewController = tabBar;
//    self.window.rootViewController = [[SZLoginViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)checkNetworkStates
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    [_reacha startNotifier];
}

- (void)networkChange
{
    NSString *tips;
    NetworkStates currentStates = [SZNetworkTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
        case NetworkStatesWIFI:
            tips = nil;
            break;
        default:
            break;
    }
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}
@end
