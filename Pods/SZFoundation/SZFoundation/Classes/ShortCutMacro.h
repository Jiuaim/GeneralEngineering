//
//  ShortCutMacro.h
//  General
//
//  Created by llbt on 16/8/30.
//  Copyright © 2016年 Huang. All rights reserved.
//

#ifndef ShortCutMacro_h
#define ShortCutMacro_h


// 屏宽高
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
// 随机色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
// 根据iPhone6算宽高
#define kScaleFrom_iPhone6(_X_) (_X_ * (kWindowWidth/375))
// weak
#define WEAK(point) __weak __typeof(point) weak##point = point;
// block安全执行
#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
// URL 自动是否连接
#define URLString(_URL_) [NSString stringWithFormat:@"%@%@",SeverHost,_URL_]
// 沙河取对象
#define ObjectFromUserDefault(_X_) [[NSUserDefaults standardUserDefaults] objectForKey:_X_];

// 动态添加属性
#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
static char PROPERTY_NAME; \
- (PROPERTY_TYPE)PROPERTY_NAME { \
return (PROPERTY_TYPE)objc_getAssociatedObject(self, &(PROPERTY_NAME)); \
} \
- (void)SETTER_NAME :(PROPERTY_TYPE)PROPERTY_NAME { \
objc_setAssociatedObject(self, &PROPERTY_NAME, PROPERTY_NAME, OBJC_ASSOCIATION_RETAIN); \
}

// RGB
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif /* ShortCutMacro_h */
