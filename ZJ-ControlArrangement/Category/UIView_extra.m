//
//  UIView_extra.m
//  Woyoli
//
//  Created by jamie on 14-11-25.
//  Copyright (c) 2014年 Missionsky. All rights reserved.
//

#import "UIView_extra.h"

@implementation UIView (UIView)

@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic origin;
@dynamic size;

#pragma mark ---------------- Setters-----------------
-(void)setUserInterface:(BOOL)setting{
    for (UIView *subview in self.window.subviews) {
        subview.userInteractionEnabled = setting;
    }
}

-(void)setX:(CGFloat)x{
    CGRect r        = self.frame;
    r.origin.x      = x;
    self.frame      = r;
}

-(void)setY:(CGFloat)y{
    CGRect r        = self.frame;
    r.origin.y      = y;
    self.frame      = r;
}

-(void)setWidth:(CGFloat)width{
    CGRect r        = self.frame;
    r.size.width    = width;
    self.frame      = r;
}

-(void)setHeight:(CGFloat)height{
    CGRect r        = self.frame;
    r.size.height   = height;
    self.frame      = r;
}

-(void)setOrigin:(CGPoint)origin{
    self.x          = origin.x;
    self.y          = origin.y;
}

-(void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

-(void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

-(void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark ---------------- Getters-----------------
-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)centerX {
    return self.center.x;
}

-(CGFloat)centerY {
    return self.center.y;
}

-(UIView *)lastSubviewOnX{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.x > outView.x)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

-(UIView *)lastSubviewOnY{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.y > outView.y)
                outView = v;
        
        return outView;
    }
    
    return nil;
}

#pragma mark ---------------- other-----------------
/**
 * @brief 移除此view上的所有子视图
 */
- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    return;
}

/**
 @brief 弹窗
 @param title 弹窗标题
 message 弹窗信息
 */
+ (void) showAlertView: (NSString*) title andMessage: (NSString *) message
{
    dispatch_async(dispatch_get_main_queue() , ^{
        
//        BOOL  show = [UIView isErrorAlertShowing:title];
//        if (!show) {
            UIAlertView *alert = [[UIAlertView alloc] init];
            alert.title = title;
            alert.message = message;
            [alert addButtonWithTitle:@"确定"];
            [alert show];
            //[alert release];
            alert = nil;
//        }
        
        //判断是否是提示登录超时
        if ([title containsString:@"登录超时"] || [message containsString:@"登录超时"]) {
//            [UserInstance sharedInstance].isLogin = NO;
//            [[UserInstance sharedInstance].userInfoDict removeAllObjects];
        }
    });
}

//+(BOOL)isErrorAlertShowing:(NSString *)title{
//    for (UIWindow* window in [UIApplication sharedApplication].windows) {
//        NSArray* subviews = window.subviews;
//        if ([subviews count] > 0)
//            if ([[subviews objectAtIndex:0] isKindOfClass:[UIAlertView class]]){
//                UIAlertView  * aler =  [subviews objectAtIndex:0] ;
//                if ([aler.title isEqualToString:NetLINK_error]) {
//                   return YES;
//                }else{
//                   return NO;
//                }
//            }else{
//                return NO;
//            }
//    }
//    return NO;
//}




/**
 *  弹窗
 *
 *  @param title    弹窗标题
 *  @param message  弹窗信息
 *  @param delegate 弹窗代理
 */
+ (void) showAlertView: (NSString*) title
            andMessage: (NSString *) message
          withDelegate: (UIViewController<UIAlertViewDelegate> *) delegate
{
    dispatch_async(dispatch_get_main_queue() , ^{
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = title;
        alert.message = message;
        alert.delegate = delegate;
        alert.tag = vAlertTag;
        [alert addButtonWithTitle:@"确定"];
        [alert show];
        alert = nil;
    });
}

+(instancetype)itemWithFrame:(CGRect)frame backgroundColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view;
}


@end
