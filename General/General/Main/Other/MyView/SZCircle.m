//
//  SZCircle.m
//  test2
//
//  Created by llbt on 16/9/7.
//  Copyright © 2016年 huang All rights reserved.
//

#import "SZCircle.h"

@implementation SZCircle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.outCircleColor = [UIColor grayColor];
        self.outFillColor = [UIColor whiteColor];
        self.inFillColor = [UIColor grayColor];
        self.outCircleWidth = 1;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self drawCircleWithContext:ctx rect:rect radio:1 circleColor:self.outCircleColor fillColor:self.outFillColor circleWidth:self.outCircleWidth];
    [self drawCircleWithContext:ctx rect:rect radio:0.25 circleColor:[UIColor clearColor] fillColor:self.inFillColor circleWidth:0];
}


- (void)drawCircleWithContext:(CGContextRef)ctx rect:(CGRect)rect radio:(CGFloat)radio circleColor:(UIColor *)circleColor fillColor:(UIColor *)fillColor circleWidth:(CGFloat)circleWidth {
    CGMutablePathRef path = CGPathCreateMutable();
    if (radio != 1) rect = CGRectMake(rect.size.width / 2.0 - rect.size.width * radio / 2.0, rect.size.height / 2.0 - rect.size.height * radio / 2.0, rect.size.width * radio - 1, rect.size.height * radio - 1);
    CGPathAddEllipseInRect(path, NULL, rect);
    CGContextAddPath(ctx, path);
    CGContextSetStrokeColorWithColor(ctx, circleColor.CGColor);
    CGContextSetLineWidth(ctx, circleWidth);
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGPathRelease(path);
}


- (void)changeStatusWithColorArray:(NSArray *)colorArray {
    self.outCircleColor = colorArray.firstObject;
    self.outFillColor = [colorArray objectAtIndex:1];
    self.inFillColor = [colorArray objectAtIndex:2];
    [self setNeedsDisplay];
}
@end
