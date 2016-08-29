//
//  UIView+Category.m
//  General
//
//  Created by llbt on 16/8/26.
//  Copyright © 2016年 Huang. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)



+ (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return nil;
}


/**
 *  垂直快速布局
 *
 *  @param viewArr   view的数组
 *  @param offsetArr 间距数组
 */
- (UIView *)addSubviewsWithVerticalLayout:(NSArray *)viewArr offsets:(NSArray *)offsetArr {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *lastView = viewArr[0];
    for (int i = 0; i < viewArr.count; i++) {
        
        UIView *view = viewArr[i];
        [self addSubview:view];
        CGFloat offset = [offsetArr[i] doubleValue];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            if (i==0) {
                make.top.equalTo(self).offset(offset);
            } else {
                make.top.equalTo(lastView.mas_bottom).offset(offset);
            }
            if (i == viewArr.count - 1){
                make.bottom.equalTo(self);
            }
        }];
        lastView = view;
    }
    return self;
}

/**
 *  wrapper
 *
 *  @param edges edges
 */
- (UIView *)wrapperViewWithEdges:(UIRectEdge)edges {
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.clipsToBounds = YES;
    [wrapperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).offset(edges);
    }];
    return wrapperView;
}

+ (UIView *)horizonSeperateViewWithArray:(NSArray *)viewName categorys:(NSArray *)categorys HVPortion:(CGFloat)portion {
    CGFloat padding = [categorys[0] floatValue];
    CGFloat inter = [categorys[1] floatValue];
    CGFloat top = [categorys[2] floatValue];
    CGFloat bottom = [categorys[3] floatValue];
    
    CGFloat width = (kScreenWidth - padding * 2 - (viewName.count - 1) * inter) / viewName.count;
    UIView *baseView = [[UIView alloc] init];
    for (int i = 0; i < viewName.count; i++) {
        Class class = NSClassFromString(viewName[i]);
        UIView *view = [[class alloc] init];
        view.backgroundColor = kRandomColor
        [baseView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(baseView).offset(padding + (width + inter) * i);
            make.top.equalTo(baseView).offset(top);
            make.bottom.equalTo(baseView).offset(bottom);
            make.width.equalTo(@(width));
            make.height.equalTo(@(width * portion));
        }];
    }
    return baseView;
}
@end
