//
//  UITabBar+Badge.h
//  QuickBidSmart
//
//  Created by xinyu on 2017/11/2.
//  Copyright © 2017年 xinyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItmIndex:(int)index;

- (void)hideBadgeOnItemIndex:(int)index;

@end
