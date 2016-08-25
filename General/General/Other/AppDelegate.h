//
//  AppDelegate.h
//  General
//
//  Created by llbt on 16/8/25.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MojoDatabase;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MojoDatabase *database;
@end

