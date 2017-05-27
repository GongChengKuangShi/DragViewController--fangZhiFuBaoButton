//
//  DragDeleteButton.m
//  Button
//
//  Created by xiangronghua on 2017/5/26.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "DragDeleteButton.h"

@implementation DragDeleteButton

- (void)drawRect:(CGRect)rect {
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    CGFloat radius = MIN(w, h) / 2.0f;
    
    self.backgroundColor = [UIColor grayColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGContextMoveToPoint(context, w / 4, h / 4);
    CGContextAddLineToPoint(context, w / 4 * 3, h / 4 * 3);
    CGContextMoveToPoint(context, w / 4, h / 4 * 3);
    CGContextAddLineToPoint(context, w / 4 * 3, h / 4);
    CGContextAddPath(context, bezierPath.CGPath);
    
    CGContextSetLineWidth(context, 0.75f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokePath(context);
}

@end
