//
//  UITabBar+Badge.m
//  QuickBidSmart
//
//  Created by xinyu on 2017/11/2.
//  Copyright © 2017年 xinyu. All rights reserved.
//

#import "UITabBar+Badge.h"
#define TabbarItemNums 5.0

@implementation UITabBar (Badge)
//显示红点
- (void)showBadgeOnItmIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 9988+index;
    bview.layer.cornerRadius = 4;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame;
    
    float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
}

//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews) {
        if (subView.tag == 9988+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
