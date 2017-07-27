//
//  YYAnimTickView.h
//  YYDemo
//
//  Created by yy on 2017/7/27.
//  Copyright © 2017年 yy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYAnimTickView;

@protocol YYAnimTickViewDelegate <NSObject>

@optional

- (void)animTickViewValueChanged:(YYAnimTickView *)tickView;

@end

@interface YYAnimTickView : UIView

@property(nonatomic,assign)BOOL isTick;

@property(nonatomic,weak)id<YYAnimTickViewDelegate> animTickDelegate;

- (instancetype)initWithFrame:(CGRect)frame backGroundColor:(UIColor *)backColor tickColor:(UIColor *)tickColor;

@end
