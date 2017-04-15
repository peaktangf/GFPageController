//
//  GFMaskView.m
//  GFSegmentedControl
//
//  Created by 谭高丰 on 2017/4/12.
//  Copyright © 2017年 谭高丰. All rights reserved.
//

#import "GFMaskView.h"

@implementation GFMaskView

#pragma mark - draw

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 画矩形
    path = [self drawReact:CGRectMake(0, 0, rect.size.width, rect.size.height - self.triangleHeight) fillColor:self.fillColor];
    // 画三角形
    CGPoint pointOne   = CGPointMake(rect.size.width/2 - self.triangleWidth/2, rect.size.height - self.triangleHeight);
    CGPoint pointTwo   = CGPointMake(rect.size.width/2, rect.size.height);
    CGPoint pointThree = CGPointMake(rect.size.width/2 + self.triangleWidth/2, rect.size.height - self.triangleHeight);
    path = [self drawTrianglePointOne:pointOne pointTwo:pointTwo pointThree:pointThree fillColor:self.fillColor];
}

#pragma mark - setter

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

- (void)setTriangleWidth:(CGFloat)triangleWidth {
    _triangleWidth = triangleWidth;
    [self setNeedsDisplay];
}

- (void)setTriangleHeight:(CGFloat)triangleHeight {
    _triangleHeight = triangleHeight;
    [self setNeedsDisplay];
}

#pragma mark - private

// 画矩形
- (UIBezierPath *)drawReact:(CGRect)rect fillColor:(UIColor *)fillColor {
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [fillColor setFill];
    [rectPath fill];
    return rectPath;
}

// 画三角形
- (UIBezierPath *)drawTrianglePointOne:(CGPoint)pointOne pointTwo:(CGPoint)pointTwo pointThree:(CGPoint)pointThree fillColor:(UIColor *)fillColor {
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    // 起点
    [trianglePath moveToPoint:pointOne];
    // draw the lines
    [trianglePath addLineToPoint:pointTwo];
    [trianglePath addLineToPoint:pointThree];
    [trianglePath closePath];
    [fillColor set];
    [trianglePath fill];
    return trianglePath;
}

@end
