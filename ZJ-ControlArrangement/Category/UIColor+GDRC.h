//
//  UIColor+GDRC.h
//  GDRCIphone
//
//  Created by KSL on 2018/12/25.
//  Copyright © 2018 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GDRC)

/**
 获取颜色
 
 @param stringToConvert 颜色值
 @return 颜色对象
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 获取颜色
 
 @param hexString 颜色值
 @param alpha 透明度
 @return 颜色对象
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
