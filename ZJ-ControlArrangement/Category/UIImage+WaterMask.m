//
//  UIImage+WaterMask.m
//  GFEWalletGFEWalletIphone
//
//  Created by huangjundong on 30/3/17.
//
//

#import "UIImage+WaterMask.h"
#import <Accelerate/Accelerate.h>


#define effectTag 19999  //毛玻璃tag

//#define blurViewTag 20180501  //毛玻璃tag

@implementation UIImage (WaterMask)

-(UIImage *)addMask:(NSString *)string{
    NSString* mark = string;
   int w = self.size.width;
   int h = self.size.height;
    UIGraphicsBeginImageContext(self.size);
//    [self drawInRect:CGRectMake(0, 0, w, h)];
    NSDictionary *attr = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:80],NSForegroundColorAttributeName : [UIColor whiteColor]};
    [mark drawInRect:CGRectMake((w-350)/2, (h-100)/2, 350, 100) withAttributes:attr];                 //左上角
    
    
    UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    aimg = [self imageByApplyingAlpha:0.5 image:aimg];
    
//    self = [self addImage:self toImage:aimg];
    
    return [self addImage:self toImage:aimg];
//中文支持有问题
//    int w = self.size.width;
//    int h = self.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
//    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
//    char* text = "abcd";
//    CGContextSelectFont(context, "Georgia", 80, kCGEncodingMacRoman);
//    CGContextSetTextDrawingMode(context, kCGTextFill);
//    CGContextSetRGBFillColor(context, 255, 255, 255, 0.5);
//    CGContextShowTextAtPoint(context, w/2-strlen(text)*80/2, h/2, text, strlen(text));
//    
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    
//    self = [UIImage imageWithCGImage:imageMasked];
    
//    return self;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image2.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}



-(UIImage *)addLogo:(UIImage *)logo{
    //get image width and height
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [logo drawInRect:CGRectMake((self.size.width-logo.size.width)/2, (self.size.height-logo.size.height)/2, logo.size.width, logo.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)imgNameForCurrentScreen:(NSString *)imgname
{
    CGFloat height = 0;
    height = [UIScreen mainScreen].bounds.size.height;
    NSString *imgName = [imgname copy];
    if (height == 480)
    {
        imgName = [NSString stringWithFormat:@"%@640*960",imgName];
    }
    else if (height == 568)
    {
        imgName = [NSString stringWithFormat:@"%@640*1136",imgName];
    }
    else if (height == 667)
    {
        imgName = [NSString stringWithFormat:@"%@750*1334",imgName];
    }
    else if (height == 736)
    {
        imgName = [NSString stringWithFormat:@"%@1242*2208",imgName];
    }
    else if (height == 812)
    {
        imgName = [NSString stringWithFormat:@"%@1125*2436",imgName];
    }
    UIImage *image = [UIImage imageNamed:imgName];
    return image;
}

#pragma mark - BlurEffect
+(void)addBlurEffect
{
    if (kIOS8_OR_LATER) {
        UIBlurEffect *blurEffet = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blurEffet];
        blurView.frame = [UIScreen mainScreen].bounds;
        blurView.tag = effectTag;
        [[[UIApplication sharedApplication] keyWindow] addSubview:blurView];
    }else{
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        imageView.tag = effectTag;
        imageView.image = [self blurImage];
        [[[UIApplication sharedApplication] keyWindow] addSubview:imageView];
        //    imageView.hidden = YES;
    }
    
}

+(void)showBlurrEffect
{
    /*
    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
    for (id object in subViews) {
        if ([[object class] isSubclassOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)object;
            if(imageView.tag == effectTag){
                
                imageView .hidden = NO;
            }
        }
    }*/
    
    UIView *view = [[[UIApplication sharedApplication] keyWindow] viewWithTag:effectTag];
    if (view) {
        view.hidden = NO;
    }
    else {
        [self addBlurEffect];
    }
}

+(void)removeBlurEffect {
//    NSArray *subViews = [[UIApplication sharedApplication] keyWindow].subviews;
//    for (id object in subViews) {
//        if ([[object class] isSubclassOfClass:[UIImageView class]]) {
//            UIImageView *imageView = (UIImageView *)object;
//            if(imageView.tag == effectTag)
//            {
//                [UIView animateWithDuration:0.2 animations:^{
//                    imageView.alpha = 0;
//                    [imageView removeFromSuperview];
//                }];
//
//            }
//        }
//    }
    
    
    UIView *imageView = [[[UIApplication sharedApplication] keyWindow] viewWithTag:effectTag];
    if (imageView) {
        imageView.hidden = YES;
        [imageView removeFromSuperview];
    }
//    [UIView animateWithDuration:0.2 animations:^{
//        imageView.alpha = 0;
//        [imageView removeFromSuperview];
//    }];
    
    
//    UIView *view = [[[UIApplication sharedApplication] keyWindow] viewWithTag:blurViewTag];
//    if (view) {
//        view.hidden = YES;
//    }
}

//毛玻璃效果
+(UIImage *)blurImage {
    UIImage *image = [[self screenShot] imgWithBlur];
    //保存图片到照片库(test)
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

//屏幕截屏
+(UIImage *)screenShot {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(screenWidth*screenScale, screenHeight*screenScale), YES, 0);
    //设置截屏大小
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, screenWidth*screenScale,screenHeight*screenScale);
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return sendImage;
}

#pragma mark - Blur

- (UIImage *)imgWithBlur {
    return [self imgWithLightAlpha:0.1 radius:10 colorSaturationFactor:1];
}

- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor {
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    return [self imgBluredWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}

// 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
    
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }

        effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    @try {
        if (hasBlur) {
            CGContextSaveGState(outputContext);
            if (maskImage) {
                CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
            }
            CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
            CGContextRestoreGState(outputContext);
        }
    }
    @catch (NSException* e) {
        
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}







+(UIImage*)circleImage:(UIImage*) image withParam:(CGFloat) inset {
    
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为0，颜色为灰色
    
    CGContextSetLineWidth(context,0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.width - inset *2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    //在圆区域内画出image原图
    
    [image drawInRect:rect];
    
    CGContextAddEllipseInRect(context, rect);
    
    CGContextStrokePath(context);
    
    //生成新的image
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;
    
}



@end
