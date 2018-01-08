//
//  UIButton+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 12-11-23.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>

//title image的相对位置
typedef NS_ENUM(NSUInteger, KIButtonEdgeInsetsStyle) {
    KIButtonEdgeInsetsStyleTop, // image在上，label在下
    KIButtonEdgeInsetsStyleLeft, // image在左，label在右
    KIButtonEdgeInsetsStyleBottom, // image在下，label在上
    KIButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (KIAdditions)
//点击区域
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

/**************************************************
 *     设置 title  image  相关
 **************************************************/
- (void)setTitle:(NSString *)title;

- (void)setImage:(UIImage *)normal;

- (void)setImage:(UIImage *)normal
     highlighted:(UIImage *)highlighted
        disabled:(UIImage *)disabled
        selected:(UIImage *)selected;

- (void)setBackgroundImage:(UIImage *)normal;

- (void)setBackgroundImage:(UIImage *)normal
               highlighted:(UIImage *)highlighted
                  disabled:(UIImage *)disabled
                  selected:(UIImage *)selected;

- (void)setTitleColor:(UIColor *)normal;

- (void)setTitleColor:(UIColor *)normal
          highlighted:(UIColor *)highlighted
             disabled:(UIColor *)disabled
             selected:(UIColor *)selected;

/**************************************************
 *     布局 title  image  相关
 *
 *  设置button的titleLabel和imageView的布局样式，及间距
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 **************************************************/
- (void)layoutButtonWithEdgeInsetsStyle:(KIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;
@end
