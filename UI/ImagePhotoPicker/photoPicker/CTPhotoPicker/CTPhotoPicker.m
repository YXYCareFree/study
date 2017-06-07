//
//  CTPhotoPicker.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTPhotoPicker.h"

#import "CTPhotoPickerLoader.h"
#import "CTPickerHeaderView.h"
//#import "Localization.h"
#import "TZImagePickerController.h"

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

#define kItemHeight 50.0f
#define kSpacing 7.0f
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCollectionViewHeight 178.0f

#define kButtonIndexTag 1000
#define kLineIndexTag   2000

#define kTitleFont [UIFont systemFontOfSize:12]

#define kItemBackgroundColor [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6f]

#define kItemTitleColor [UIColor blackColor]
#define kItemTitleFont  [UIFont systemFontOfSize:14]


@interface CTPhotoPickerSheetView : UIView <UINavigationControllerDelegate, UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, assign) NSInteger cancelButtonIndex;

@property (nonatomic, strong) NSArray *assertArray;
@property (nonatomic, assign) BOOL isChosePhotoFromHeaderView;
@property (nonatomic, strong) UIButton *photoButton;

@property (nonatomic, strong) CTPhotoPicker *picker;

@property (nonatomic, strong) CTPickerHeaderView *titleView;

@end

@implementation CTPhotoPickerSheetView {
    NSString *_title;
    NSString *_cancelTitle;
    NSArray *_otherTitles;
    
    UIView *_topView;
    UIView *_bottomView;
    
    NSMutableArray<UIButton *> *_buttons;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles
{
    self = [super init];
    
    if (self) {
        _title = title;
        _cancelTitle = cancelTitle;
        _otherTitles = otherTitles;
        _buttons = [NSMutableArray array];
        
        [self setupView];
    }
    
    return self;
}

- (void)dealloc
{
}

- (void)setupView
{
    self.frame = [UIScreen mainScreen].bounds;
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
    
    // Top view
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor clearColor];
    topView.frame = self.bounds;
    topView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleWidth;
    [self addSubview:topView];
    _topView = topView;
    
    // Bottom view
    UIView *bottomView;
    
//    double version = [[UIDevice currentDevice].systemVersion doubleValue];
//    if (version >= 8.0f) {
//        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//        bottomView = [[UIVisualEffectView alloc] initWithEffect:blur];
//    }
//    else if (version >= 7.0f) {
//        bottomView = [UIToolbar new];
//    }
//    else {
//        bottomView = [UIView new];
//        bottomView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];;
//    }
    
    bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:226.0f/255.f blue:236.0f/255.0f alpha:1];;

    _bottomView = bottomView;
    
    CGFloat height;
    
    [self setupTitleView];
    CGSize size = _titleView.bounds.size;
    
    height = (kItemHeight + kSpacing) + (_otherTitles.count * kItemHeight) + size.height;
    
    bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, height);
    [self addSubview:bottomView];
    
    // Cancel button
    UIButton *cancelButton = [[UIButton alloc] init];
    cancelButton.frame = CGRectMake(0, CGRectGetHeight(bottomView.bounds) - kItemHeight, kScreenWidth, kItemHeight);
    [cancelButton setTitleColor:kItemTitleColor forState:UIControlStateNormal];
    [cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = kItemTitleFont;
    cancelButton.backgroundColor = kItemBackgroundColor;
    
    [self addTargetAction:cancelButton];
    [_buttons addObject:cancelButton];
    
    [bottomView addSubview:cancelButton];
    
    // Items
    for (NSString *title in _otherTitles) {
        NSInteger index = [_otherTitles indexOfObject:title];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = kItemBackgroundColor;
        
        if (index == 0) {
            self.photoButton = btn;
        }
        
        CGFloat height = (50 * _otherTitles.count) + kSpacing;
        CGFloat y = (CGRectGetMinY(cancelButton.frame) + (index * (kItemHeight))) - height;
        
        [btn setFrame:CGRectMake(0, y, kScreenWidth, kItemHeight)];
        btn.tag = index + kButtonIndexTag;
        [btn setTitleColor:kItemTitleColor forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = kItemTitleFont;
        
        [self addTargetAction:btn];
        [_buttons addObject:btn];
        
        btn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        [bottomView addSubview:btn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5f)];
        line.tag = index + kLineIndexTag;
        line.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1];
        line.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
        [btn addSubview:line];
    }
    
    self.cancelButtonIndex = _otherTitles.count + 1;
    cancelButton.tag = self.cancelButtonIndex + kButtonIndexTag;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        topView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - height);
        topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        bottomView.frame = CGRectMake(0, kScreenHeight - height, kScreenWidth, height + 10);
        
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(dismiss)];
        [topView addGestureRecognizer:tap];
        bottomView.frame = CGRectMake(0, kScreenHeight - height, kScreenWidth, height);
        [UIView animateWithDuration:0.2 animations:^{
            if (height > kScreenHeight) {
                [weakSelf adaptUIBaseOnOriention];
            }
        }];
    }];
}

- (void)setupTitleView
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
        return;
    }
    
    CTPickerHeaderView *titleView = [CTPickerHeaderView new];
    titleView.frame = CGRectMake(0, 0, kScreenWidth, 190);
    titleView.allowsMultiple = self.picker.allowsMultiple;
    titleView.maxCount = self.picker.maxCount;
    titleView.backgroundColor = kItemBackgroundColor;
    
    __weak typeof(self) weakSelf = self;
    titleView.sendAssets = ^(NSArray *assertArray){
        //        改变row 0 的标题和作用
        UIButton *button = weakSelf.photoButton;
        
        if (assertArray.count == 0) {
            weakSelf.isChosePhotoFromHeaderView = NO;
            [button setTitle:@"拍照" forState:UIControlStateNormal];
            [button setTitleColor:kItemTitleColor forState:UIControlStateNormal];
            button.titleLabel.font = kItemTitleFont;
        }
        else{
            weakSelf.isChosePhotoFromHeaderView = YES;
            weakSelf.assertArray = assertArray;
            NSString *title = @"发送";
            if (assertArray.count > 1) {
                title = [NSString stringWithFormat:@"发送 %lu 张",(unsigned long)assertArray.count];
            }
            else {
                title = @"发送";
            }
            [button setTitle:title
                    forState:UIControlStateNormal];

            UIColor *color = [UIColor colorWithRed:255 / 255.0 green:28 / 255.0 blue:109 / 255.0 alpha:1];
            [button setTitleColor:color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
    };
    
    [_bottomView addSubview:titleView];
    _titleView = titleView;
}

- (void)adaptUIBaseOnOriention
{
    CGSize size = _titleView.bounds.size;
    
    CGFloat height = (kItemHeight + kSpacing) + (_otherTitles.count * kItemHeight) + size.height;
    
    _topView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - height);
    
    CGFloat buttonHeight = kItemHeight;
    
    if (height > kScreenHeight) {
        _bottomView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        CGFloat remainingHeight = kScreenHeight - CGRectGetHeight(_titleView.bounds) -kSpacing;
        buttonHeight = remainingHeight / (_otherTitles.count + 1);
    }
    else {
        _bottomView.frame = CGRectMake(0, kScreenHeight - height, kScreenWidth, height);
    }
    
    UIButton *cancelButton = (UIButton *)[self viewWithTag:(self.cancelButtonIndex + kButtonIndexTag)];
    cancelButton.frame = CGRectMake(0, CGRectGetHeight(_bottomView.bounds) - buttonHeight, kScreenWidth, buttonHeight);
    
    for (NSString *title in _otherTitles) {
        NSInteger index = [_otherTitles indexOfObject:title];
        
        UIButton *btn = (UIButton *)[_bottomView viewWithTag:(index + kButtonIndexTag)];
        CGFloat y = (buttonHeight * index) + CGRectGetHeight(_titleView.bounds);
        btn.frame = CGRectMake(0, y, kScreenWidth, buttonHeight);
        
        UIView *line = [btn viewWithTag:(index + kLineIndexTag)];
        line.frame = CGRectMake(0, 0.5f, kScreenWidth, 0.5f);
    }
}

- (void)scaleToSmall:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        [btn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.0f]];
    }];
}

- (void)scaleAnimation:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        [btn setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.0f]];
    }];
}

- (void)scaleToDefault:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        [btn setBackgroundColor:kItemBackgroundColor];
    }];
}

- (void)onButtonClicked:(UIButton *)btn
{
    NSInteger index = (btn.tag - kButtonIndexTag);
    
    if (self.cancelButtonIndex == index) {
        
        if ([self.picker.delegate respondsToSelector:@selector(didCancelPickingImages:)]) {
            [self.picker.delegate didCancelPickingImages:self.picker];
        }
        
        [self dismiss];
        return;
    }
    
    if (index == 0 && _assertArray.count > 0) {
        CTPhotoPicker *picker = self.picker;
        if (picker.delegate) {
            if (self.isChosePhotoFromHeaderView && [picker.delegate respondsToSelector:@selector(photoPicker:didFinishPickingAssets:theOriginal:)]) {
                [picker.delegate photoPicker:picker didFinishPickingAssets:_assertArray theOriginal:YES];
            }
        }
        [self dismiss];
        return;
    }
    
    [self dismissBlock:index remove:NO];
    [self takePhotoOrChooseFromLib:index];
}

- (void)dismissBlock:(NSInteger)index
{
    [self dismissBlock:index remove:YES];
}

- (void)dismissBlock:(NSInteger)index remove:(BOOL)remove
{
    __weak typeof(self) weakSelf = self;
    CGFloat height = ((kItemHeight + 0.5f) + kSpacing) + (_otherTitles.count * (kItemHeight + 0.5f)) + kCollectionViewHeight;
    UIView *topView = _topView;
    UIView *bottomView = _bottomView;
    
    [UIView animateWithDuration:0.4f delay:0 usingSpringWithDamping:0.8f initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        topView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
        bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, height);
    } completion:^(BOOL finished) {
        [weakSelf.superview sendSubviewToBack:weakSelf];
        
        if (remove) {
            [weakSelf removeFromSuperview];
        }
    }];
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    // 不允许禁用user interaction，保持弹出视图占用
    [super setUserInteractionEnabled:YES];
}

#pragma mark - Public methods

- (void)show
{
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
        window = [[UIApplication sharedApplication].delegate window];
    }
    
    if (!window) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    [window endEditing:YES];
    [window addSubview:self];

}

- (void)showVC:(UIViewController *)vc{

    [vc.view addSubview:self];
    //vc.view.backgroundColor = [UIColor blackColor];
}

- (void)dismiss
{
    [self dismissBlock:self.cancelButtonIndex];
}

- (void)addTargetAction:(UIButton *)button
{
    [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(scaleToSmall:)
           forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [button addTarget:self action:@selector(scaleAnimation:)
           forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(scaleToDefault:)
           forControlEvents:UIControlEventTouchDragExit];
}

- (void)removeFromSuperview
{
    for (UIButton *button in _buttons) {
        [button removeTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button removeTarget:self action:@selector(scaleToSmall:)
         forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
        [button removeTarget:self action:@selector(scaleAnimation:)
         forControlEvents:UIControlEventTouchUpInside];
        [button removeTarget:self action:@selector(scaleToDefault:)
         forControlEvents:UIControlEventTouchDragExit];
    }
    
    [super removeFromSuperview];
}

#pragma mark - 启动相机或者相册

- (void)takePhotoOrChooseFromLib:(NSInteger)indexPathRow
{
    if (indexPathRow == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self alertWithTitle:nil andMessage:@"相机不可用" andButtonTitle:@"确定" andButtonTitle:nil];
            [self removeFromSuperview];
            return;
        }
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
            [self alertWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相机”选项中，允许访问你的相机。" andButtonTitle:@"确定" andButtonTitle:nil];
            [self removeFromSuperview];
            return;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = self.picker.allowsEditing;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        if (self.picker.useFrontCamera && [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
        UIViewController *controller = (UIViewController *)self.picker.context;
        [controller presentViewController:picker animated:YES completion:^{
        }];
    }
    else if (indexPathRow == 1) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self alertWithTitle:nil
                      andMessage: @"相册不可用"
                  andButtonTitle: @"确定"
                  andButtonTitle:nil];
            [self removeFromSuperview];
            return;
        }
        
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
            [self alertWithTitle:nil
                      andMessage:@"请在iPhone的“设置-隐私-相机”选项中，允许访问你的相机。"
                  andButtonTitle:@"确定" andButtonTitle:nil];
            [self removeFromSuperview];
            return;
        }
        
        NSInteger maxCount = 1;
        if (self.picker.allowsMultiple) {
            maxCount = self.picker.maxCount;
        }
        
        TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxCount delegate:self];
        picker.allowPickingOriginalPhoto = NO;
        picker.allowPickingVideo = NO;
        
        UIViewController *controller = (UIViewController *)self.picker.context;
        [controller presentViewController:picker animated:YES completion:^{
        }];
    }
}

#pragma mark - Save to photos album

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
}

#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets
{
    if ([self.picker.delegate respondsToSelector:@selector(photoPicker:didFinishPickingImages:)]) {
        [self.picker.delegate photoPicker:self didFinishPickingImages:photos];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

#pragma mark - UIPickerViewDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    if ([self.picker.delegate respondsToSelector:@selector(photoPicker:didFinishPickingImages:)]) {
        [self.picker.delegate photoPicker:self.picker didFinishPickingImages:[NSArray arrayWithObject:image]];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([self.picker.delegate respondsToSelector:@selector(didCancelPickingImages:)]) {
        [self.picker.delegate didCancelPickingImages:self.picker];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self removeFromSuperview];
}

- (UIAlertView *)alertWithTitle:(NSString *)title andMessage:(NSString *)message andButtonTitle:(NSString *)titleOne andButtonTitle:(NSString *)titleTwo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:titleOne
                                          otherButtonTitles:titleTwo, nil];
    [alert show];
    return alert;
}

@end

/**
 * CTPickerViewController
 */

@implementation CTPhotoPicker {
    __weak CTPhotoPickerSheetView *_actionSheetView;
    
    NSString *_title;
    NSString *_cancelTitle;
    NSArray *_otherTitles;
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSArray *)otherTitles
{
    self = [super init];
    
    if (self) {
        _title = title;
        _cancelTitle = cancelTitle;
        _otherTitles = otherTitles;
        _maxCount = NSUIntegerMax;
    }
    
    return self;
}

- (instancetype)init
{
    NSArray *otherButtons = @[@"拍照", @"从手机相册中选择"];
    NSString *cancel = @"取消";
    return [self initWithTitle:nil
              cancelButtonTitle:cancel
              otherButtonTitles:otherButtons];
}

- (void)setAllowsEditing:(BOOL)allowsEditing
{
    _allowsEditing = allowsEditing;
}

- (void)setAllowsMultiple:(BOOL)allowsMultiple
{
    _allowsMultiple = allowsMultiple;
    
    CTPhotoPickerSheetView *sheet = _actionSheetView;
    sheet.titleView.allowsMultiple = allowsMultiple;
}

- (void)setMaxCount:(NSUInteger)maxCount
{
    if (maxCount <= 0) {
        maxCount = 1;
    }

    _maxCount = maxCount;
}

- (NSInteger)cancelButtonIndex
{
    return _actionSheetView.cancelButtonIndex;
}

- (void)show
{
    if (!_actionSheetView) {
        CTPhotoPickerSheetView *view = [[CTPhotoPickerSheetView alloc] initWithTitle:_title cancelButtonTitle:_cancelTitle otherButtonTitles:_otherTitles];
        view.titleView.allowsMultiple = self.allowsMultiple;
        view.titleView.maxCount = self.maxCount;
        view.picker = self;
        [view show];
        
        _actionSheetView = view;
    }
}

- (void)showInVC:(UIViewController *)vc{

    if (!_actionSheetView) {
        CTPhotoPickerSheetView *view = [[CTPhotoPickerSheetView alloc] initWithTitle:_title cancelButtonTitle:_cancelTitle otherButtonTitles:_otherTitles];
        view.titleView.allowsMultiple = self.allowsMultiple;
        view.titleView.maxCount = self.maxCount;
        view.picker = self;
        //[view show];
        [view showVC:vc];
        _actionSheetView = view;
    }
}

- (void)dismiss
{
    [_actionSheetView dismiss];
}


@end

