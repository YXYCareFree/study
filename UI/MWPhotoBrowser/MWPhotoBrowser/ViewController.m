//
//  ViewController.m
//  MWPhotoBrowser
//
//  Created by beyondSoft on 16/10/12.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"

@interface ViewController ()<TZImagePickerControllerDelegate, MWPhotoBrowserDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)];
    [_imageView addGestureRecognizer:tap];
}

- (void)imageClicked{

    MWPhotoBrowser * browser = [MWPhotoBrowser new];
    browser.delegate = self;
    browser.zoomPhotosToFill = NO;
    browser.displayNavArrows = NO;
    browser.displayActionButton = NO;
   // browser.displaySelectionButtons = NO;//右上角选择按钮
    browser.alwaysShowControls = NO;
   // browser.enableGrid = YES;
    browser.enableSwipeToDismiss = YES;
//    browser.startOnGrid = YES;
//    browser.autoPlayOnAppear = YES;

    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
    [self presentViewController:browser animated:YES completion:nil];
}

- (IBAction)selectPhotoBtnClicked:(id)sender {


  //设置最多选择的图片数initWithMaxImagesCount
    TZImagePickerController * imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:self];

    imagePickerVC.sortAscendingByModificationDate = NO;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
#pragma mark--MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    return [[MWPhoto alloc] initWithImage:_imageView.image];
}
#pragma mark--TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{

    _imageView.image = photos[0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
