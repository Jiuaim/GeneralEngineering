//
//  SZCircle.h
//  test2
//
//  Created by llbt on 16/9/7.
//  Copyright © 2016年 huang All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZCircle : UIView

@property (nonatomic, assign) CGFloat outCircleWidth;

@property (nonatomic, strong) UIColor *outCircleColor;

@property (nonatomic, strong) UIColor *outFillColor;

@property (nonatomic, assign) CGFloat inCircleWidth;

@property (nonatomic, strong) UIColor *inFillColor;


- (void)changeStatusWithColorArray:(NSArray *)colorArray;

@end
