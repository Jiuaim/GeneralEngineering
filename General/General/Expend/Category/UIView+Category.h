//
//  UIView+Category.h
//  General
//
//  Created by llbt on 16/8/26.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

/**
 *  获取最顶层window
 */
+ (UIWindow *)lastWindow;


/**
 *  快速垂直布局
 */
- (UIView *)addSubviewsWithVerticalLayout:(NSArray *)viewArr offsets:(NSArray *)offsetArr;

@end
