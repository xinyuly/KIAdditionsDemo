//
//  UIViewController+KIViewController.m
//  Kitalker
//
//  Created by 杨 烽 on 12-7-28.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "UIViewController+KIAdditions.h"

@implementation UIViewController (KIAdditions)

- (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController withAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self pushViewController:viewController animated:animated];
    } else if (self.navigationController != nil) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (void)popViewController {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self popViewControllerAnimated:YES];
    }
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController withAnimated:YES];
}

- (void)presentViewController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    [self presentViewController:viewController animated:animated completion:^{
    }];
}

- (void)dismissModalViewController {
    if (self.navigationController != nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)presentWithNavigationController:(UIViewController *)viewController {
    [self presentWithNavigationController:viewController withAnimated:YES];
}

- (void)presentWithNavigationController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if (viewController != nil) {
        UINavigationController *navController = nil;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            navController = (UINavigationController *)viewController;
        } else {
            navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        [self presentViewController:navController withAnimated:animated];
        navController = nil;
    }
}

- (void)close {
    if (self.presentingViewController != nil) {
       [self dismissModalViewController];
    } else {
        [self popViewController];
    }
}

/**************************************************
 *     导航栏添加按钮相关
 **************************************************/
- (void)showBackBarItem {
    [self showLeftBarItem:@"icon_nav_back.png" highlightedImage:@"icon_nav_back_h.png" selector:@selector(backAction)];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)showLeftBarItem:(NSString *)imageName highlightedImage:(NSString *)imageNameH selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 32, 32)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageNameH] forState:UIControlStateHighlighted];
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -3;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,item];
}

- (void)showRightBarItem:(NSString *)imageName highlightedImage:(NSString *)imageNameH selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 32, 32)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageNameH] forState:UIControlStateHighlighted];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -3;
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,saveItem];
}

- (void)showRightBarButtonItem:(NSString *)title selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:13];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
//    CGSize size = [title sizeWithFont:btn.titleLabel.font forWidth:120 lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size = [title boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size;
    CGFloat width = MIN(120, size.width + 12);
    [btn setFrame:CGRectMake(0, 0, width, 24)];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setEnabled:YES];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -3;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,item];
}

- (void)showLeftBarButtonItem:(NSString *)title selector:(SEL)selector {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:13];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
//    CGSize size = [title sizeWithFont:btn.titleLabel.font forWidth:120 lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size = [title boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : btn.titleLabel.font} context:nil].size;
    CGFloat width = MIN(120, size.width + 12);
    [btn setFrame:CGRectMake(0, 0, width, 24)];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [btn setEnabled:YES];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

@end
