//
//  UIView+KIView.m
//  Kitalker
//
//  Created by 杨 烽 on 12-7-6.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "UIView+KIAdditions.h"
#import <objc/runtime.h>

static char KI_VIEW_USER_INFO_KEY;

#define kWaitViewTag 1010110

@implementation UIView (KIAdditions)

@dynamic userInfo;

- (void)setUserInfo:(id)userInfo {
    if (userInfo == nil) {
        return ;
    }
    objc_setAssociatedObject(self, &KI_VIEW_USER_INFO_KEY, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, &KI_VIEW_USER_INFO_KEY);
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    [self.layer setMasksToBounds:masksToBounds];
}

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}

// 设置圆角
- (void)setCornerRadius:(CGFloat)radius {
    [self.layer setCornerRadius:radius];
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

// 设置边框颜色 和 边框宽度
- (void)setBorderColor:(UIColor *)borderColor {
    [self.layer setBorderColor:borderColor.CGColor];
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

// 设置外阴影
- (void)setShadowColor:(UIColor *)shadowColor {
    [self.layer setShadowColor:shadowColor.CGColor];
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    [self.layer setShadowOpacity:shadowOpacity];
}

- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    [self.layer setShadowOffset:shadowOffset];
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    [self.layer setShadowRadius:shadowRadius];
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

/*快照*/
- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)clearBackgroundColor {
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)setBackgroundImage:(UIImage *)image {
    UIColor *color = [UIColor colorWithPatternImage:image];
    [self setBackgroundColor:color];
}

- (void)setIndex:(NSInteger)index {
    if (self.superview != nil) {
        [self.superview insertSubview:self atIndex:index];
    }
}

- (void)bringToFront {
    if (self.superview != nil) {
        [self.superview bringSubviewToFront:self];
    }
}

- (void)sendToBack {
    if (self.superview != nil) {
        [self.superview sendSubviewToBack:self];
    }
}

- (void)registEndEditing {
    UITapGestureRecognizer *endEditingTapGesture = nil;
    endEditingTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(endEditingTapGestureHandler:)];
    [endEditingTapGesture setCancelsTouchesInView:YES];
    [self addGestureRecognizer:endEditingTapGesture];
    endEditingTapGesture = nil;
}

- (void)endEditingTapGestureHandler:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if ([self isKindOfClass:[UITableView class]]) {
            [self.superview endEditing:YES];
        } else {
            [self endEditing:YES];
        }
    }
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)radius {
    CALayer *layer = self.layer;
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    [layer setBorderColor:color.CGColor];
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

- (void)setShadowColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowOffset:offset];
    [self.layer setShadowRadius:blurRadius];
}

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target selector:(SEL)selector {
    UITapGestureRecognizer *tapGesure = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesure];
    [self setUserInteractionEnabled:YES];
    return tapGesure;
}

- (UIViewController *)viewController {
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

- (UIActivityIndicatorView *)waitView {
    UIActivityIndicatorView *av = [self viewWithTag:kWaitViewTag];
    if (av == nil) {
        av = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [av setTag:kWaitViewTag];
        [av setHidesWhenStopped:YES];
        [av setUserInteractionEnabled:NO];
        [self addSubview:av];
    }
    return av;
}

- (void)showWaitingView:(void(^)(UIActivityIndicatorView *waitView))block {
    [[self waitView] setCenter:CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5)];
    [self bringSubviewToFront:[self waitView]];
    [[self waitView] startAnimating];
    if (block != nil) {
        block([self waitView]);
    }
}

- (void)hideWaitingView:(void(^)(UIActivityIndicatorView *waitView))block {
    [[self waitView] stopAnimating];
    if (block != nil) {
        block([self waitView]);
    }
}

- (BOOL)isWaiting {
    return [[self waitView] isAnimating];
}

/*设置顶部圆角*/
- (void)setCornerOnTop:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/*设置底部圆角*/
- (void)setCornerOnBottom:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/*设置左边圆角*/
- (void)setCornerOnLeft:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/*设置右边圆角*/
- (void)setCornerOnRight:(CGFloat )cornerRadius {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
/*设置四边圆角*/
- (void)setAllCorner {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          cornerRadius:10.0];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


@end
