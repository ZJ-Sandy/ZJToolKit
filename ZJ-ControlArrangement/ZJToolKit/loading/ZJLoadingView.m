//
//  MKLoadingView.m
//  Taoqicar
//
//  Created by xmk on 16/10/13.
//  Copyright © 2016年 taoqicar. All rights reserved.
//

#import "ZJLoadingView.h"

@interface ZJLoadingView()

@property (nonatomic, strong) UILabel *labInfo;   /*!< 提示信息 */
@property (nonatomic, strong) UIView *viewBg;     /*!< 背景view */
@property (nonatomic, strong) UIImageView *imgLoading;  /*!< loading图片 */
@property (nonatomic, strong) UITapGestureRecognizer *gesture;  /*!< 是否添加手势 */
@end

static ZJLoadingView *s_loadingView;

@implementation ZJLoadingView

+ (ZJLoadingView *)initAnimation{
    return [self initAnimationCanCancel:NO];
}

+ (ZJLoadingView *)initAnimationCanCancel:(BOOL)cancel{
    if (!s_loadingView) {
        s_loadingView = [[ZJLoadingView alloc] init];
        s_loadingView.backgroundColor = [UIColor clearColor];
        s_loadingView.frame = ZJ_SCREEN_BOUNDS;
        
        [s_loadingView addSubview:s_loadingView.viewBg];
        [s_loadingView.viewBg addSubview:s_loadingView.labInfo];
    }
    [s_loadingView setCanCancel:cancel];
    [s_loadingView starAnimation];
    return s_loadingView;
}

- (void)starAnimation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 9999;
    [s_loadingView.imgLoading.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)setCanCancel:(BOOL)cancel{
    if (cancel) {
        self.gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:self.gesture];
    }else{
        [self removeGestureRecognizer:self.gesture];
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)sender{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self removeFromSuperview];
}

- (void)setMessage:(NSString *)message{
    _message = message;
    self.labInfo.text = message;
}

- (UIView *)viewBg{
    if (!_viewBg) {
        CGRect tempFrame;
        tempFrame.size.height = 82;
        tempFrame.size.width = 108;
        tempFrame.origin.x = ZJ_SCREEN_WIDTH/2 - tempFrame.size.width/2;
        tempFrame.origin.y = ZJ_SCREEN_HEIGHT/2 - tempFrame.size.height/2;
        
        _viewBg = [[UIView alloc] initWithFrame:tempFrame];
        _viewBg.backgroundColor = ZJ_COLOR_RGBA(0, 0, 0, 0.6);
        _viewBg.layer.cornerRadius = 4;
        _viewBg.layer.masksToBounds = YES;
        
        CGFloat imgWidth = 32;
        CGFloat top = 12;
        self.imgLoading.frame = CGRectMake((tempFrame.size.width-imgWidth)/2, top, imgWidth, imgWidth);
        [_viewBg addSubview:self.imgLoading];
    }
    return _viewBg;
}

- (UIImageView *)imgLoading{
    if (!_imgLoading) {
        _imgLoading = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refresh_icon_luntai"]];
    }
    return _imgLoading;
}

- (UILabel *)labInfo{
    if (!_labInfo) {
        _labInfo = [[UILabel alloc]initWithFrame:CGRectMake(0, 52, 108, 20)];
        _labInfo.textAlignment = NSTextAlignmentCenter;
        _labInfo.textColor = [UIColor whiteColor];
        _labInfo.font = [UIFont systemFontOfSize:14];
    }
    return _labInfo;
}

@end
