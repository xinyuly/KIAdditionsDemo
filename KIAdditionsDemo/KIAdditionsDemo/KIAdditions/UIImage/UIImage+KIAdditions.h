//
//  UIImage+KIImage.h
//  Kitalker
//
//  Created by 杨 烽 on 12-8-3.
//
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (KIAdditions)
/*颜色转图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/*垂直翻转*/
- (UIImage *)flipVertical;

/*水平翻转*/
- (UIImage *)flipHorizontal;

/*改变size*/
- (UIImage *)resizeTo:(CGSize)size;

- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;

/*等比例缩小图片至该宽度*/
- (UIImage *)scaleWithWidth:(CGFloat)width;

/*等比例缩小图片至该高度*/
- (UIImage *)scaleWithHeight:(CGFloat)heigh;

/*裁切*/
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

/*修正拍照图片方向*/
- (UIImage *)fixOrientation;

/*获取图片某个像素点的颜色*/
- (UIColor *)colorAtPixel:(CGPoint)point;

- (UIImage *)decoded;

- (UIImage*)blurredImage:(CGFloat)blurAmount;

/**
 对图片进行压缩，返回压缩之后的 data

 @param maxSize 为想要压缩到的最大文件大小，该值只是一个理想值，不一定会达到；
 @param minCompression 为压缩之后的最小质量；
 @param maxResolution 为压缩之后最大分辨率；
 @return data
 */
- (NSData *)compressToMaxSize:(NSInteger)maxSize
               minCompression:(CGFloat)minCompression
                maxResolution:(CGFloat)maxResolution;

/*截屏*/
+ (UIImage*)screenshot;

//添加水印
- (UIImage *)addMsakImage:(UIImage *)maskImage;
@end
