//
//  ViewController.m
//  UIImage
//
//  Created by beyondSoft on 16/7/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // [self createImageWithColor];
    //[self createImageFromView];
//只能获取前面的整数不能判断小数点
    //NSUInteger _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];

    UIImage * image = [UIImage imageNamed:@"2.jpg"];
//    UIImage * fixedImage = [self fixImage:image imageWithAlphaComponent:0.5];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(30, 60, fixedImage.size.width, fixedImage.size.height);
//    imageView.alpha = 0.5;
    imageView.frame = CGRectMake(100, 90, 100, 100);
//    imageView.contentMode = UIViewContentModeScaleToFill;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(3, 3)];
    CAShapeLayer * maskLayer = [CAShapeLayer new];
    maskLayer.frame = imageView.bounds;
    maskLayer.path = path.CGPath;
    imageView.layer.mask = maskLayer;
    
    
    [self.view addSubview:imageView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //UIImageWriteToSavedPhotosAlbum([self screenShot], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
#pragma mark--修改图片透明度
- (UIImage *)fixImage:(UIImage *)fixedImage imageWithAlphaComponent:(CGFloat)alpha
{
    UIImage *image = fixedImage;

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
#pragma mark--屏幕截屏
- (UIImage *)screenShot
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;

    int scale = 1;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        scale = [[UIScreen mainScreen] scale];
    }

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(window.bounds.size.width, window.bounds.size.height - 20),1,scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, -20);

    [window.layer renderInContext:context];

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return  image;
}
#pragma mark--根据十六进制数生成color
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)createImageFromView{

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 400, 100, 100)];

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 200, 200)];
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView1.image = [UIImage imageNamed:@"11"];
    [view addSubview:imageView1];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];

   UIImage * captureImage = [self captureImageFromView:imageView1 rect:CGRectMake(0, 0, 100, 100)];
    imageView.image = captureImage;
    [self.view addSubview:imageView];
}

- (void)createImageWithColor{

    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
    UIImage * createWithColor = [self createImageWithUIColor:[UIColor redColor]];
    imageView1.image = createWithColor;
    [self.view addSubview:imageView1];
}

#pragma mark--从一个视图上面截取一部分生成图片
- (UIImage *)captureImageFromView:(UIView *)view rect:(CGRect)rect{

    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef ref = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage *i = [UIImage imageWithCGImage:ref];
    CGImageRelease(ref);

    return i;
}

#pragma mark--重新绘制图片大小（即缩放）
- (UIImage *)resizeImage:(UIImage *)image reSize:(CGSize )reSize{

    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
#pragma mark--根据颜色生成图片
- (UIImage *)createImageWithUIColor:(UIColor *)color{
    
    CGSize size = CGSizeMake(1, 1);//默认设置
    UIScreen *screen = [UIScreen mainScreen];
    UIGraphicsBeginImageContextWithOptions(size, 0, screen.scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存图片到系统相册
     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    return image;
}

#pragma mark--保存图片到系统相册
// UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);  保存图片到系统相册需实现image:didFinishSavingWithError:contextInfo:此回调方法（用于判断是否保存成功）
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    if (error || !image) {
        NSLog(@"保存图片至系统相册失败");
    }else{
        NSLog(@"保存图片至系统相册成功");
    }
}

@end
