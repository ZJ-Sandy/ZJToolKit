//
//  ZJUIHelper.m
//  ZJ-ControlArrangement
//
//  Created by 志杰 on 2019/7/26.
//  Copyright © 2019 志杰. All rights reserved.
//

#import "ZJUIHelper.h"
#import "ZJUITools.h"
#import "UIView+Toast.h"
#import "ZJLoadingView.h"

@implementation ZJUIHelper

#pragma mark - ------ toast ------
+ (void)showToast:(NSString *)message{
    UIViewController *curVc = [self getCurrentViewController];
    if (curVc.view.window) {
        [curVc.view.window makeToast:message];
    } else {
        [[ZJUITools getCurrentWindow] makeToast:message];
    }
}

#pragma mark - ------ loading ------
static ZJLoadingView *s_loadView;
+ (void)showLoadingViewWith:(NSString *)msg canCannel:(BOOL)cancel{
    UIWindow *window = [ZJUITools getCurrentWindow];
    if (window) {
        s_loadView = [ZJLoadingView initAnimationCanCancel:cancel];
        [window addSubview:s_loadView];
        s_loadView.hidden = NO;
        if (msg) {
            s_loadView.message = msg;
        } else {
            s_loadView.message = @"加载中...";
        }
    }
}

+ (void)showLoadingViewWith:(NSString *)msg{
    [self showLoadingViewWith:msg canCannel:NO];
}

+ (void)hideLoadingview{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (s_loadView) {
        [s_loadView removeFromSuperview];
        s_loadView = nil;
    }
}

#pragma mark - ----- current ViewController -----
+ (UIViewController *)getCurrentViewController{
    return [ZJUITools getCurrentViewController];
}

+ (UIViewController *)getCurrentViewControllerIsIncludePresentedVC:(BOOL)isIncludePVC{
    return [ZJUITools getCurrentViewControllerIsIncludePresentedVC:isIncludePVC];
}

+ (UIViewController *)getCurrentViewControllerWithWindowLevel:(CGFloat)windowLevel includePresentedVC:(BOOL)isIncludePVC{
    return [ZJUITools getCurrentViewControllerWithWindowLevel:windowLevel includePresentedVC:isIncludePVC];
}

+ (UIViewController *)getPresentedViewController{
    return [ZJUITools getPresentedViewController];
}

@end
