//
//  UIImage+KIFilter.m
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import "UIImage+KIFilter.h"

@implementation UIImage (KIFilter)

- (UIImage *)imageWithFilterName:(NSString *)filterName {
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, image, nil];
    [filter setDefaults];
    CIImage *outputImage = [filter outputImage];
    UIImage *result = [UIImage imageWithCIImage:outputImage];
    
    return result;
}

//线性SRGB色调曲线
- (UIImage *)linearToSRGBToneCurve {
    return [self imageWithFilterName:@"CILinearToSRGBToneCurve"];
}

//铬黄
- (UIImage *)photoEffectChrome {
    return [self imageWithFilterName:@"CIPhotoEffectChrome"];
}

//褪色
- (UIImage *)photoEffectFade {
    return [self imageWithFilterName:@"CIPhotoEffectFade"];
}

//怀旧
- (UIImage *)photoEffectInstant {
    return [self imageWithFilterName:@"CIPhotoEffectInstant"];
}

//单色
- (UIImage *)photoEffectMono {
    return [self imageWithFilterName:@"CIPhotoEffectMono"];
}

//黑白
- (UIImage *)photoEffectNoir {
    return [self imageWithFilterName:@"CIPhotoEffectNoir"];
}

//冲印
- (UIImage *)photoEffectProcess {
    return [self imageWithFilterName:@"CIPhotoEffectProcess"];
}

//色调
- (UIImage *)photoEffectTonal {
    return [self imageWithFilterName:@"CIPhotoEffectTonal"];
}

//岁月
- (UIImage *)photoEffectTransfer {
    return [self imageWithFilterName:@"CIPhotoEffectTransfer"];
}

//SRGB色调曲线到线性
- (UIImage *)SRGBToneCurveToLinear {
    return [self imageWithFilterName:@"CISRGBToneCurveToLinear"];
}

//插图
- (UIImage *)vignetteEffect {
    return [self imageWithFilterName:@"CIVignetteEffect"];
}

@end
