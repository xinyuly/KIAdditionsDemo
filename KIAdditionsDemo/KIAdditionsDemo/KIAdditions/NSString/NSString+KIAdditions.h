//
//  NSString+KIString.h
//  Kitalker
//
//  Created by 杨 烽 on 12-7-6.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KIString(xxx, ...) [NSString stringWithFormat:xxx, ##__VA_ARGS__]

@interface NSString (KIAdditions)

+ (BOOL)isEmptyString:(NSString *)string;

+ (BOOL)isNotEmptyString:(NSString *)string;

/*判断是否为空或者nil*/
- (BOOL)isNotEmptyString;

/*返回实际的长度，一个中文字符算作两个长度*/
- (NSUInteger)actualLength;

/*去除空格*/
- (NSString *)trimWhitespace;

/*去除左右空格*/
- (NSString *)trimLeftAndRightWhitespace;

/*去除html标签*/
- (NSString *)trimHTMLTag;

/*判断是否为空白字符串*/
- (BOOL)isWhitespace;

/*判断是否匹配某个正则*/
- (BOOL)isMatchesRegularExp:(NSString *)regex;

/*判断是否为email*/
- (BOOL)isEmail;

/*返回URL的正则表达式*/
- (NSString *)URLPattern;

/*判断是否为URL*/
- (BOOL)isURL;

/*返回其中包含的URL列表*/
- (NSArray *)URLList;

/*判断是否为手机号码*/
- (BOOL)isCellPhoneNumber;

/*判断是否为电话号码*/
- (BOOL)isPhoneNumber;

/*判断是否为中国地区邮编*/
- (BOOL)isZipCode;

- (id)jsonObject:(NSError **)error;

/*转换为数值进行比较*/
- (NSComparisonResult)numericCompare:(NSString *)string;
- (NSComparisonResult)floatCompare:(NSString *)string;

/**
 返回值是该字符串所占的大小(width, height)
 
 @param font 字符串所用的字体
 @param maxSize 如果显示一行,则宽高都设置为MAXFLOAT, 如果显示为多行,只需将宽设置一个有限定长值
 @return size
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end

@interface NSObject (String)

/*判断是否为字符串*/
- (BOOL)isString;

@end
