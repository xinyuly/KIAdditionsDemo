//
//  UIImage+KIFilter.h
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KIFilter)

// https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

/**************************************************
 *              图片滤镜相关
 **************************************************/
- (UIImage *)imageWithFilterName:(NSString *)filterName;

//线性SRGB色调曲线
- (UIImage *)linearToSRGBToneCurve;

//铬黄
- (UIImage *)photoEffectChrome;

//褪色
- (UIImage *)photoEffectFade;

//怀旧
- (UIImage *)photoEffectInstant;

//单色
- (UIImage *)photoEffectMono;

//黑白
- (UIImage *)photoEffectNoir;

//冲印
- (UIImage *)photoEffectProcess;

//色调
- (UIImage *)photoEffectTonal;

//岁月
- (UIImage *)photoEffectTransfer;

//SRGB色调曲线到线性
- (UIImage *)SRGBToneCurveToLinear;

//插图
- (UIImage *)vignetteEffect;

@end
