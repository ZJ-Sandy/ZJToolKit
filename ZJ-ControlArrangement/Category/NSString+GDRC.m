//
//  NSString+GDRC.m
//  GDRCIphone
//
//  Created by KSL on 2019/1/2.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import "NSString+GDRC.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation NSString (GDRC)

#pragma mark - 获取IP
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    //    NSArray *searchArray = preferIPv4 ?
    //    (@[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ]) :
    //    (@[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ]) ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
         address = addresses[key];
         if([self isValidatIP:address]) {
             *stop = YES;
         }
     } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

#pragma mark - 获取时间戳
/**
 *  获取当前时间戳拼接随机字符串到20位
 *
 *  @return 当前时间戳拼接随机字符串
 */
+ (NSString *)getTimeStampAndRandomString {
    
    NSString *timeStamp = [self getTimeStamp];
    
    NSString *chatString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:0];
    [chatString enumerateSubstringsInRange:NSMakeRange(0, chatString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [arrM addObject:substring];
    }];
    
    int num = 20 - (int)timeStamp.length;
    NSMutableString *stringM = @"".mutableCopy;
    
    for (int i = 0; i < num; ++i) {
        
        int value = arc4random() % arrM.count;
        NSString *str = arrM[value];
        [stringM appendString:str];
        
    }
    
    NSString *timeStampAndRandomString = [NSString stringWithFormat:@"%@%@",[self getTimeStamp], stringM];
    
    return timeStampAndRandomString;
}

/**
 *  获取当前时间戳
 *
 *  @return 时间戳
 */
+ (NSString *)getTimeStamp {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSDate *zeroTimeZoneDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc]init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFmt setTimeZone:timeZone];
    [dateFmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentTimeZoneDate = [dateFmt stringFromDate:zeroTimeZoneDate];
    
    return [self getTimeCounter:currentTimeZoneDate];
}

/**
 *  转化成时间戳
 *
 *  @param exStr 传入的时间字符串
 *
 *  @return 返回时间戳字符串
 */
+ (NSString *)getTimeCounter:(NSString*)exStr {
    NSDate* exDate = [self getDateFromStrHMS:exStr];
    //NSString* timeNow = [Utils getStrFromDate:[NSDate date]];
    //NSDate* nowDate = [Utils getDateFromStrHMS:timeNow];
    NSTimeInterval interval = [exDate timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f",interval];
}

+ (NSDate *)getDateFromStrHMS:(NSString*)aStr {
    NSDateFormatter *dateForMatter = [self dateFormatterForDateAndTime];
    return [dateForMatter dateFromString:aStr];
}

+ (NSDateFormatter *)dateFormatterForDateAndTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return dateFormatter;
}

#pragma mark - 判断字符串是否为空串/为空/为string类型
+ (BOOL)checkString:(NSString *)str {
    if (str != nil && [str isKindOfClass: [NSString class]] && str.length > 0) {
        return YES;
    }
    return NO;
}


+ (NSString *)stringByAddingWith:(NSString *)str{
    NSString *string = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)encodeComponent{
   return [self stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
