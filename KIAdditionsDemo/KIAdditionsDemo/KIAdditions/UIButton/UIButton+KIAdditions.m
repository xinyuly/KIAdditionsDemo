//
//  UIButton+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 12-11-23.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "UIButton+KIAdditions.h"
#import <objc/runtime.h>

@implementation UIButton (KIAdditions)

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";
/**************************************************
 *     响应域相关
 **************************************************/
- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero)|| !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

/**************************************************
 *     设置 title  image  相关
 **************************************************/
- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)normal; {
    [self setImage:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setImage:(UIImage *)normal
     highlighted:(UIImage *)highlighted
        disabled:(UIImage *)disabled
        selected:(UIImage *)selected {
    
    [self setImage:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setImage:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setImage:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setImage:selected forState:UIControlStateSelected];
    }
}

- (void)setBackgroundImage:(UIImage *)normal {
    [self setBackgroundImage:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setBackgroundImage:(UIImage *)normal
               highlighted:(UIImage *)highlighted
                  disabled:(UIImage *)disabled
                  selected:(UIImage *)selected {
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setBackgroundImage:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setBackgroundImage:selected forState:UIControlStateSelected];
    }
}

- (void)setTitleColor:(UIColor *)normal {
    [self setTitleColor:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setTitleColor:(UIColor *)normal
          highlighted:(UIColor *)highlighted
             disabled:(UIColor *)disabled
             selected:(UIColor *)selected {
    [self setTitleColor:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setTitleColor:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setTitleColor:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setTitleColor:selected forState:UIControlStateSelected];
    }
}

/**************************************************
 *     布局 title  image  相关
 *
 *  设置button的titleLabel和imageView的布局样式，及间距
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 **************************************************/
- (void)layoutButtonWithEdgeInsetsStyle:(KIButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    /**
     KIButtonEdgeInsetsStyleTop, // image在上，label在下
     KIButtonEdgeInsetsStyleLeft, // image在左，label在右
     KIButtonEdgeInsetsStyleBottom, // image在下，label在上
     KIButtonEdgeInsetsStyleRight // image在右，label在左
     */
    switch (style) {
        case KIButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case KIButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case KIButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case KIButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }

    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end
