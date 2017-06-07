//
//  ViewController.m
//  ImagePhotoPicker
//
//  Created by beyondSoft on 16/5/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "CTPhotoPicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AppDelegate.h"
#import "CTSoundUtil.h"

@interface ViewController ()<CTPhotoPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@property (nonatomic, strong) UIImagePickerController * pickerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self selectPhoto];
//    });
   [CTSoundUtil soundTip];
}

- (void)selectPhoto{

    _pickerVC = [[UIImagePickerController alloc] init];
    _pickerVC.delegate = self;
    _pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _pickerVC.allowsEditing = YES;
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController presentViewController:_pickerVC animated:YES completion:nil];
}
#pragma mark--UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

      AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //获取选择的照片
    _imageView.image = info[UIImagePickerControllerOriginalImage];

    [app.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
      AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image withName:(NSString *)name{

    NSData * imageData = UIImagePNGRepresentation(image);
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * totalPath = [documentPath stringByAppendingPathComponent:name];
    [imageData writeToFile:totalPath atomically:NO];

}

- (IBAction)btn:(id)sender {

    CTPhotoPicker * picker = [[CTPhotoPicker alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.allowsMultiple = YES;
    picker.context = self;
    //[picker show];
    picker.useFrontCamera = NO;
    [picker showInVC:self];
}

- (void)didCancelPickingImages:(id)picker{

}
//拍照片回调
- (void)photoPicker:(id)picker didFinishPickingImages:(NSArray *)images{

    if (images.count == 0) {
        return;
    }
    self.imageView.image = images[0];
    //_imageView2.image = images[1];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [self processImage:images[0]];
    });

}
//选取照片回调
- (void)photoPicker:(id)picker didFinishPickingAssets:(NSArray *)assets theOriginal:(BOOL)theOriginal{

    if (assets.count == 0) {
        return;
    }
    NSArray *selectAssets = [NSArray arrayWithArray:assets];
    typeof(self) __weak weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        ALAsset *asset = selectAssets.firstObject;
        // get image
        UIImage *fullScreenImage = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage scale:asset.defaultRepresentation.scale orientation:(int)asset.defaultRepresentation.orientation];

        [self performSelectorOnMainThread:@selector(setImage:) withObject:fullScreenImage waitUntilDone:NO];

        [weakSelf processImage:fullScreenImage];
    });
}

- (void)setImage:(UIImage *)image{
    self.imageView.image = image;
}
- (void)processImage:(UIImage *)image{

    //先调整一下图片的方向
    UIImage * fixedImage = H5ReSizeImage(image, image.size);


    NSString * path = [NSString stringWithFormat:@"%@/test", NSTemporaryDirectory()];


   // [UIImagePNGRepresentation(fixedImage) writeToFile:path atomically:YES];

    //此方法转化成NSData的大小要比png方法小,如果要求图片质量不高可以使用此方法上传
    [UIImageJPEGRepresentation(fixedImage, 1) writeToFile:path atomically:YES];

    NSData * fileData = [NSData dataWithContentsOfFile:path];

    NSString * base64Data = [fileData base64Encoding];
}

UIImage *H5ReSizeImage(UIImage *image, CGSize reSize)
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return reSizeImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
