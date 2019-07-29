//
//  MKDatePickerView.h
//  Cheyoubang
//
//  Created by xmk on 2016/11/8.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJDatePickerView;
typedef void(^MKDatePickerViewBlock)(ZJDatePickerView *datePickerView, NSDate *date);


@interface ZJDatePickerView : UIView

@property (nonatomic, copy) MKDatePickerViewBlock block;
@property (nonatomic, assign) UIDatePickerMode datePickerModel;
@property (nonatomic, copy) NSDate *minimumDate;
@property (nonatomic, copy) NSDate *maximumDate;
@property (nonatomic, copy) NSDate *currentDate;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) UIColor *tintColor;

- (void)showWithBlock:(MKDatePickerViewBlock)block;
@end
