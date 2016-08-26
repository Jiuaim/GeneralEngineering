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
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            if (i==0) {
                make.top.equalTo(self).offset(offset);
            } else {
                make.top.equalTo(lastView.bottom).offset(offset);
            }
            if (i == viewArr.count - 1){
                make.bottom.equalTo(self);
            }
        }];
        lastView = view;
    }
    return self;
}

@end
