//
//  HmSelectAdView.h
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/28.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSelectAdView : UIView
/**
  数据回调
 **/
@property (nonatomic, copy) void (^confirmSelect)(NSArray *address);

/**
 lastContent 为传入int类型下标，跳转指定城市。
 lastContent 为空时，走默认显示
 data 为传入数据
 title  头文字的显示
 **/
- (instancetype)initWithLastContent:(NSArray *)lastContent withData:(NSData *)data withTitle:(NSString *)title;

@end
