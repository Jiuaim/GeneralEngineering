//
//  AppDelegate.m
//  General
//
//  Created by llbt on 16/8/25.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDatabase.h"
#import "ViewController.h"
#import "SZNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 数据库
    self.database = [[AppDatabase alloc] initWithMigrations];
    NSLog(@"%@",NSHomeDirectory());
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    SZNavigationController *sznavi = [[SZNavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController = sznavi;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}
@end
