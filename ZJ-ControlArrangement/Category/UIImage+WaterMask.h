//
//  UIImage+WaterMask.h
//  GFEWalletGFEWalletIphone
//
//  Created by huangjundong on 30/3/17.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (WaterMask)

-(UIImage *)addMask:(NSString *)string;
-(UIImage *)addLogo:(UIImage *)logo;

/**
 根据当前屏幕尺寸得到对应图片   会拼接后缀名 - 640*960  640*1136 750*1334 1242*2208 1125*2436
 
 @param imgname 图片名
 @return 图片
 */
+ (UIImage *)imgNameForCurrentScreen:(NSString *)imgname;

//屏幕截屏
+(UIImage *)screenShot;

/**
  在WillResignActive 失去焦点时， 生成模糊图片 但不显示
 */
+(void)addBlurEffect;

+(void)showBlurrEffect;

+(void)removeBlurEffect;


+(UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset;
@end
