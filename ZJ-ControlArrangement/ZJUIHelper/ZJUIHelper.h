//
//  ZJUIHelper.h
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJUIHelper : NSObject
/** 调用显示toast **/
+ (void)showToast:(NSString *)message;
/** 调用显示loading **/
+ (void)showLoadingViewWith:(NSString *)msg;
/** 隐藏loading **/
+ (void)hideLoadingview;
@end

NS_ASSUME_NONNULL_END
