//
//  ViewController.m
//  CoreImage
//
//  Created by beyondSoft on 16/5/3.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>
#import "SvGifView.h"

@interface ViewController ()
{
    UIImageView * imageV;
    NSTimer * timer;
    SvGifView * gifView;
}
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    //[self filter];
//    [self animation];

    [self searchFace];

   // [self loadGifView];
}

- (void)loadGifView{

    NSURL * fileUrl = [[NSBundle mainBundle] URLForResource:@"jiafei" withExtension:@"gif"];
    gifView = [[SvGifView alloc] initWithCenter:CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2) fileURL:fileUrl];

    gifView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:gifView];
    [gifView startGif];
}

- (void)searchFace{

    NSString * path1 = [[NSBundle mainBundle] pathForResource:@"1" ofType:@".jpg"];
   // NSString * path2 = [[NSBundle mainBundle] pathForResource:@"2" ofType:@".jpg"];

    UIImage * image1 = [UIImage imageWithContentsOfFile:path1];


    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 260)];


    UIGraphicsBeginImageContext(CGSizeMake(150, 260));
    [image1 drawInRect:CGRectMake(0, 0, 150, 260)];
    UIImage * reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    imageV.image  = reSizeImage;

   // imageV.image = image1;
    [self.view addSubview:imageV];

    CIImage * ciImage = [[CIImage alloc] initWithImage:reSizeImage];

    CIContext * context = [CIContext contextWithOptions:nil];
    NSDictionary * opts = @{CIDetectorAccuracy : CIDetectorAccuracyHigh};
    CIDetector * detector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:opts];

    NSArray * features = [detector featuresInImage:ciImage options:opts];

    for (CIFaceFeature * f in features) {

        if (f.hasLeftEyePosition) {
            NSLog(@"Left eye %g %g", f.leftEyePosition.x, f.leftEyePosition.y);

        }
        if (f.hasRightEyePosition) {
            NSLog(@"Right eye %g %g", f.rightEyePosition.x, f.rightEyePosition.y);

        }
        if (f.hasMouthPosition) {
            NSLog(@"Mouth %g %g", f.mouthPosition.x, f.mouthPosition.y);
    
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    NSLog(@"%f %f", touchPoint.x, touchPoint.y);
}

- (void)animation{

    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 90, 90)];
    UIImage * image = [UIImage imageNamed:@"1.png"];
    imageV.image = image;
    imageV.layer.cornerRadius = 45;
    [self.view addSubview:imageV];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(round) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)round{
    static int i = 0;
    i++;
    imageV.transform = CGAffineTransformMakeRotation(i * M_PI/300);
}

- (void)filter{

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 80, 90, 90)];

    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 90, 90)];

    UIImage * image = [UIImage imageNamed:@"1.png"];

    imageView1.image = image;

    //将UIImage转化为CIImage
    CIImage * ciImage = [[CIImage alloc] initWithImage:image];

    //创建过滤器
    CIFilter * filter = [CIFilter filterWithName:@"CIFalseColor" keysAndValues:kCIInputImageKey, ciImage, nil];
    //使用过滤器默认的属性
    [filter setDefaults];

    //获取绘制上下文
    CIContext * context = [CIContext contextWithOptions:nil];
    //渲染并输出CIImage
    CIImage * outputImage = [filter outputImage];

    //创建CGImageRef句柄
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    //获取图片
    image = [UIImage imageWithCGImage:cgImage];
    //释放CGImageRef句柄
    CGImageRelease(cgImage);

    imageView.image = image;
    [self.view addSubview:imageView];
    [self.view addSubview:imageView1];
}

- (void)setName:(NSString *)name{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
