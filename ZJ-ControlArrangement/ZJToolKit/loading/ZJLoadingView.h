//
//  MKLoadingView.h
//  Taoqicar
//
//  Created by xmk on 16/10/13.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJLoadingView : UIView

@property (nonatomic,copy) NSString *message;

+ (ZJLoadingView *)initAnimation;
+ (ZJLoadingView *)initAnimationCanCancel:(BOOL)cancel;
@end
