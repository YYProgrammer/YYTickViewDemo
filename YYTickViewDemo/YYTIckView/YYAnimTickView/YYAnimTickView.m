//
//  YYAnimTickView.m
//  YYDemo
//
//  Created by yy on 2017/7/27.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "YYAnimTickView.h"

@interface YYAnimTickView ()

@property (nonatomic,strong) UIColor *backColor;

@property (nonatomic,strong) UIColor *tickColor;

@property (nonatomic,weak) CAShapeLayer *shape;

@end

@implementation YYAnimTickView

- (instancetype)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)backColor tickColor:(UIColor *)tickColor
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.backColor = backColor;
        self.tickColor = tickColor;
        self.isTick = NO;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)setIsTick:(BOOL)isTick
{
    _isTick = isTick;
    
    if (self.animTickDelegate != nil && [self.animTickDelegate respondsToSelector:@selector(animTickViewValueChanged:)])
    {
        [self.animTickDelegate animTickViewValueChanged:self];
    }
    
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.isTick)
    {
        /** 填充背景 */
        CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width*0.5 - rect.size.width*0.03) startAngle:0 endAngle:M_PI*2 clockwise:YES];
        //设置颜色
        [self.backColor set];
        // 填充：必须是一个完整的封闭路径,默认就会自动关闭路径
        [path fill];
        
        /** 绘制勾 */
        //1、设置路线
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        path1.lineWidth = rect.size.width*0.06;
        [path1 moveToPoint:CGPointMake(rect.size.width*0.23, rect.size.height*0.43)];
        [path1 addLineToPoint:CGPointMake(rect.size.width*0.45, rect.size.height*0.7)];
        [path1 addLineToPoint:CGPointMake(rect.size.width*0.79, rect.size.height*0.35)];
        //2、创建CAShapeLayer
        CAShapeLayer *shape=[CAShapeLayer layer];
        self.shape = shape;//记录以便重绘时移除
        shape.path = path1.CGPath;
        shape.lineWidth = path1.lineWidth;
        shape.fillColor = [UIColor clearColor].CGColor;
        shape.strokeColor = self.tickColor.CGColor;
        shape.lineCap = kCALineCapRound;//线帽(线的端点)呈圆角状
        shape.lineJoin = kCALineJoinRound;//线连接处呈圆角状
        //3、给CAShapeLayer添加动画
        CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        checkAnimation.duration = 0.5;
        checkAnimation.fromValue = @(0.0f);
        checkAnimation.toValue = @(1.0f);
        [shape addAnimation:checkAnimation forKey:nil];
        //4、把CAShapeLayer添加给自己view的layer
        [self.layer addSublayer:shape];
    }
    else
    {
        [self.shape removeFromSuperlayer];
        CGPoint center = CGPointMake(rect.size.width*0.5,rect.size.height*0.5);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:(rect.size.width*0.5 - rect.size.width*0.03) startAngle:0 endAngle:M_PI*2 clockwise:YES];
        [[UIColor lightGrayColor] set];
        [path stroke];
    }
}

- (void)tapAction
{
    self.isTick = !self.isTick;
}

@end
