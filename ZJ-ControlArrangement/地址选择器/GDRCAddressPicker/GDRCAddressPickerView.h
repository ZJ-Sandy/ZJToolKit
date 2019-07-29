//
//  GDRCAddressPickerView.h
//  GDRCIphone
//
//  Created by KSL on 2019/3/8.
//  Copyright © 2019 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDRCAddressPickerView;

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectAddressCallBack)(NSDictionary *dict);

@protocol GDRCAddressPickerViewDelegate <NSObject>

@optional
- (void)GDRCAddressPickerView:(GDRCAddressPickerView *)addressPickerView selectIndex:(NSInteger)index addressID:(NSString *)addressID;

- (void)GDRCAddressPickerView:(GDRCAddressPickerView *)addressPickerView getSelectAddressInfor:(NSString *)addressInfo;

@end

@interface GDRCAddressPickerView : UIView

@property (nonatomic, weak) id<GDRCAddressPickerViewDelegate> delegate;
@property (nonatomic, copy) selectAddressCallBack callBack;


- (void)showAreaView;
- (void)hidenAreaView;

@end

NS_ASSUME_NONNULL_END
