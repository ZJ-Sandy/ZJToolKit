//
//  NSString+GDRC.h
//  GDRCIphone
//
//  Created by KSL on 2019/1/2.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GDRC)

/**
 *  获取当前设备当前 IP 地址
 *
 *  @param preferIPv4 YES=IPV4,NO=IPV6
 *
 *  @return 当前 IP
 */
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

/**
 *  获取当前时间戳
 *
 *  @return 时间戳
 */
+ (NSString *)getTimeStamp;

/**
 *  获取当前时间戳拼接随机字符串到20位
 *
 *  @return 当前时间戳拼接随机字符串
 */
+ (NSString *)getTimeStampAndRandomString;

/**
 *  判断字符串是否为空串/为空/为string类型
 *  @param str 要判断的字符串
 *  @return YES 不为空串/不为空/为string类型
 */
+ (BOOL)checkString:(NSString *)str;

/**
 *  解决url有中文问题(此方法iOS9已过时)
 */
+ (NSString *)stringByAddingWith:(NSString *)str;

/**
 *  对URL参数编码
 */
- (NSString *)encodeComponent;

@end

NS_ASSUME_NONNULL_END
