//
//  YYTestTickViewViewController.m
//  YYDemo
//
//  Created by yy on 2017/7/27.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "YYTestTickViewViewController.h"
#import "YYBasicTickView.h"
#import "YYAnimTickView.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define YY_COLOR UIColorFromRGB(0x2ecb94)

@interface YYTestTickViewViewController () <YYBasicTickViewDelegate,YYAnimTickViewDelegate>

@end

@implementation YYTestTickViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YYBasicTickView *basicTick = [[YYBasicTickView alloc] initWithFrame:CGRectMake(100, 100, 50, 50) backGroundColor:YY_COLOR tickColor:[UIColor whiteColor]];
    [self.view addSubview:basicTick];
    basicTick.basicTickDelegate = self;
    
    
    YYAnimTickView *animTick = [[YYAnimTickView alloc] initWithFrame:CGRectMake(100, 200, 50, 50) backGroundColor:YY_COLOR tickColor:[UIColor whiteColor]];
    [self.view addSubview:animTick];
    animTick.animTickDelegate = self;
}

#pragma mark - YYBasicTickViewDelegate
- (void)basicTickViewValueChanged:(YYBasicTickView *)tickView
{
    NSLog(@"Basic:%d",tickView.isTick);
}
#pragma mark - YYAnimTickViewDelegate
- (void)animTickViewValueChanged:(YYAnimTickView *)tickView
{
    NSLog(@"Anim:%d",tickView.isTick);
}

@end
