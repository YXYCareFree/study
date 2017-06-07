//
//  ViewController.m
//  UIImageHandle
//
//  Created by beyondSoft on 16/6/2.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage * image = [UIImage imageNamed:@"1.jpg"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 300)];
    imageView.image = [self scaleImage:image withScale:0.3];
    [self.view addSubview:imageView];

    //存储图片
    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"image.png"];
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"iamge",nil]];  // 保存文件的名称

    //
   // [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];

    //转为NSData保存该方法转化的NSData大小较小（清晰度要求不高时使用）
    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
    //取出数据
    NSData * data = [NSData dataWithContentsOfFile:path];
}

//缩放
- (UIImage *)scaleImage:(UIImage *)image withScale:(float)scale{

    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage * scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
