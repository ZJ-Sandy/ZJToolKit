
//
//  LZPickViewManager.m
//  smart_small
//
//  Created by LZ on 2017/7/5.
//  Copyright © 2017年 LZ. All rights reserved.
//

#import "LZPickViewManager.h"

@implementation LZPickViewManager
+ (instancetype)initLZPickerViewManager{
    return  [[self alloc] init];
}

/*  设置Picker显示 最小-最大范围  默认范围为:1991-01-01 2300:12:31
 *  maxString 最大时间
 *  minString 最小时间
 *  dateStringBlock 选择日期回调
 */
- (void)showWithMaxDateString:(NSString *)maxString withMinDateString:(NSString *)minString withCurrentDateString:(NSString *)currentString leftTitle:(NSString *)letfTitle rightTitle:(NSString *)rightTitle mainTitle:(NSString *)mainTitle didSeletedDateStringBlock:(void (^)(NSString *dateString))dateStringBlock{
    

    [self.limitDatePicker showWithMaxDateString:maxString withMinDateString:minString withCurrentDateString:currentString leftTitle:letfTitle rightTitle:rightTitle mainTitle:mainTitle didSeletedDateStringBlock:^(NSString *dateString) {
        
        if (dateStringBlock) {
            dateStringBlock(dateString);
        }
    }];
    
    
    
    
    
}


- (LZCustomLimitDatePicker *)limitDatePicker {
    if (!_limitDatePicker) {
        _limitDatePicker = [LZCustomLimitDatePicker initCustomLimitDatePicker];
    }
    return _limitDatePicker;
}

@end
