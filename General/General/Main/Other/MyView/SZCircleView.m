//
//  SZCircleView.m
//  test2
//
//  Created by llbt on 16/9/7.
//  Copyright © 2016年 huang All rights reserved.
//

#import "SZCircleView.h"
#import "SZCircle.h"
#define kMarginX 20
#define kMarginY 20
#define kInner 30

@interface SZCircleView()

@property (nonatomic, strong) NSMutableArray *password;
@property (nonatomic, assign) CGPoint currentPoint;

@end


@implementation SZCircleView
- (NSMutableArray *)password {
    if (!_password) {
        _password = [NSMutableArray array];
    }
    return _password;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i < 9; i++) {
            SZCircle *circle = [[SZCircle alloc] init];
            self.lineColor = [UIColor redColor];
            self.lineWidth = 10;
            [self addSubview:circle];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat circleHW = (self.frame.size.width - kMarginX * 2 - kInner * 2) / 3.0;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        int row = idx % 3;
        int col = idx / 3;
        
        obj.tag = idx + 1;
        CGFloat x = kMarginX + (circleHW + kInner) * row;
        CGFloat y = kMarginY + (circleHW + kInner) * col;
        obj.frame = CGRectMake(x, y, circleHW, circleHW);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.password removeAllObjects];// 清除所有保存密码
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    [self.subviews enumerateObjectsUsingBlock:^(SZCircle *circle, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(circle.frame, point)) {
            // 改变选中状态
            [circle changeStatusWithColorArray:@[[UIColor redColor],[UIColor whiteColor],[UIColor redColor]]];
            [self.password addObject:circle];
        }
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    self.currentPoint = point;
    
    [self.subviews enumerateObjectsUsingBlock:^(SZCircle *circle, NSUInteger idx, BOOL *stop) {
        if (CGRectContainsPoint(circle.frame, point)) {
            [circle changeStatusWithColorArray:@[[UIColor redColor],[UIColor whiteColor],[UIColor redColor]]];
            if (![self.password containsObject:circle]) [self.password addObject:circle];
            [self judgeCircleBetweenTwoPoint];
        }
    }];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (SZCircle *circle in self.password) {
        NSLog(@"%d",circle.tag);
    }
    self.currentPoint = CGPointZero;
    [self.password removeAllObjects];
    [self.subviews enumerateObjectsUsingBlock:^(SZCircle *circle, NSUInteger idx, BOOL *stop) {
        [circle changeStatusWithColorArray:@[[UIColor grayColor],[UIColor whiteColor],[UIColor grayColor]]];
    }];
    [self setNeedsDisplay];
}


- (void)judgeCircleBetweenTwoPoint {
    if (self.password.count <= 1) return;
    SZCircle *last = self.password.lastObject;
    SZCircle *lastBefore = [self.password objectAtIndex:self.password.count - 2];
    
    CGFloat last_1_x = last.center.x;
    CGFloat last_1_y = last.center.y;
    CGFloat last_2_x = lastBefore.center.x;
    CGFloat last_2_y = lastBefore.center.y;
    
    CGFloat middle_x = (last_1_x + last_2_x) / 2.0;
    CGFloat middle_y = (last_1_y + last_2_y) / 2.0;
    
    SZCircle *circle = [self circleWithPoint:CGPointMake(middle_x, middle_y)];
    if (circle != nil) {
        [self.password insertObject:circle atIndex:self.password.count-2];
    }
}


- (SZCircle *)circleWithPoint:(CGPoint)point {
    SZCircle *circle;
    for (SZCircle *cir in self.subviews) {
        if (CGRectContainsPoint(cir.frame, point)) {
            circle = cir;
            break;
        }
    }
    
    if ([self.password containsObject:circle]) {
        circle = nil;
    }
    return circle;
}



- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.password.count <= 1) return;
    
    [self addLineWithRect:rect];
}

- (void)addLineWithRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int index = 0; index < self.password.count; index++) {
        SZCircle *circle = self.password[index];
        if (index == 0) { // 起点按钮
            CGContextMoveToPoint(ctx, circle.center.x, circle.center.y);
        } else {
            CGContextAddLineToPoint(ctx, circle.center.x, circle.center.y); // 全部是连线
        }
    }
    
    if (self.currentPoint.x != CGPointZero.x && self.currentPoint.y != CGPointZero.y) {
        CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    }
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, self.lineWidth);
    [self.lineColor set];
    CGContextStrokePath(ctx);
}
@end
