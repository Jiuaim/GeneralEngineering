//
//  UIView+Category.h
//  General
//
//  Created by llbt on 16/8/26.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface UIView (Category)


/**
 *  获取最顶层window
 */
+ (UIWindow *)lastWindow;

/**
 *  快速垂直布局
 */
- (UIView *)addSubviewsWithVerticalLayout:(NSArray *)viewArr offsets:(NSArray *)offsetArr;

/**
 *  给view包一层
 */
- (UIView *)wrapperViewWithEdges:(UIRectEdge)edges;

/**
 *  水平等分控件
 *
 *  @param viewName  view的名字数组
 *  @param block     点击事件
 *  @param categorys 边距、间隔、顶部、底部(4个参数)
 *  @param portion   宽高比
 *
 *  @return 底层view
 */
+ (UIView *)horizonSeperateViewWithArray:(NSArray *)viewName eventBlock:(void(^)(UIView *touchView))block categorys:(NSArray *)categorys HVPortion:(CGFloat)portion;

/**
 *  给view添加事件
 *
 *  @param event 处理事件block
 */
- (void)addEventWithBlock:(void(^)(UIView *touchView))event;
@end
