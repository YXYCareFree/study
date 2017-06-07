//
//  CTPickerViewController.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTPickerViewController.h"

#import "CTPhotoPickerLoader.h"
#import "CTPickerHeaderView.h"

#import <AVFoundation/AVFoundation.h>

#define   kCTPickerViewCornerRadius         8
#define   kCTPickerViewMargin               10
#define   kCTPickerViewHeaderHeight         190
#define   kCTPickerViewCellHeight           50

#define   kCTPickerViewAnimatedDuration     0.3

static NSMutableArray *presentedControllers = nil;

@interface CTPickerViewController () <UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong) NSArray *assertArray;
@property(nonatomic, assign) BOOL isChosePhotoFromHeaderView;
@property(nonatomic, strong) UIButton *photoButton;
@property(nonatomic, strong) CTPickerHeaderView *headerView;
@property(nonatomic, strong) UITableViewCell *topCell;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation CTPickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)dealloc
{
    NSLog(@"CTPickerViewController dealloc");
}

- (UIImage *)createImageWithUIColor:(UIColor *)color size:(CGSize)size
{
    UIScreen *screen = [UIScreen mainScreen];
    UIGraphicsBeginImageContextWithOptions(size, 0, screen.scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)initView
{
    CGFloat height = kCTPickerViewCellHeight * 3 + kCTPickerViewHeaderHeight + kCTPickerViewMargin * 2;
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor orangeColor];
    topView.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - height);
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [topView addGestureRecognizer:tap];
    CGRect frame = CGRectMake(kCTPickerViewMargin,
                              CGRectGetHeight(self.view.bounds) - height,
                              CGRectGetWidth(self.view.bounds) - kCTPickerViewMargin * 2,
                              height);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = [UIView new];
    tableView.backgroundView.backgroundColor = [UIColor clearColor];
    
    self.tableView = tableView;
    
    self.headerView = [CTPickerHeaderView new];
    self.headerView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 190);
    self.headerView.layer.cornerRadius = kCTPickerViewCornerRadius;
    self.headerView.layer.masksToBounds = YES;
    self.headerView.allowsMultiple = self.allowsMultiple;
    
    __weak typeof(self) weakSelf = self;
    self.headerView.sendAssets = ^(NSArray *assertArray){
        //        改变row 0 的标题和作用
        UIButton *button = weakSelf.photoButton;
        
        if (assertArray.count == 0) {
            weakSelf.isChosePhotoFromHeaderView = NO;
            [button setTitle:@"拍照" forState:UIControlStateNormal];
            UIColor *color = [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1];
            [button setTitleColor:color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17];
        }
        else{
            weakSelf.isChosePhotoFromHeaderView = YES;
            weakSelf.assertArray = assertArray;
            [button setTitle:[NSString stringWithFormat:@"发送 %lu 张",(unsigned long)assertArray.count]
                    forState:UIControlStateNormal];
            UIColor *color = [UIColor colorWithRed:255 / 255.0 green:28 / 255.0 blue:109 / 255.0 alpha:1];
            [button setTitleColor:color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20];
        }
        
    };
    
    NSArray *items = @[@"拍照", @"相册"];
    
    self.topCell = [UITableViewCell new];
    self.topCell.layer.cornerRadius = kCTPickerViewCornerRadius;
    self.topCell.layer.masksToBounds = YES;
    self.topCell.userInteractionEnabled = YES;
    
    [self.topCell.contentView addSubview:self.headerView];
    
    UIImage *normalImage = [self createImageWithUIColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
    UIColor *highlightedColor = [UIColor colorWithRed:0xf5 / 255.0 green:0xf5 / 255.0 blue:0xf5 / 255.0 alpha:1];
    UIImage *highlightedImage = [self createImageWithUIColor:highlightedColor size:CGSizeMake(1, 1)];
    
    for (int i = 0; i < items.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        UIColor *color = [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1];
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        CGFloat y = self.headerView.frame.size.height + kCTPickerViewCellHeight * i;
        button.frame = CGRectMake(0,
                                  y,
                                  tableView.bounds.size.width, kCTPickerViewCellHeight);
        [button setTitle:items[i] forState:UIControlStateNormal];
        [self.topCell.contentView addSubview:button];
        [button addTarget:self
                   action:@selector(onItemClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            self.photoButton = button;
        }
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1];
        line.frame = CGRectMake(0, y + kCTPickerViewCellHeight, tableView.bounds.size.width, 1);
        [self.topCell addSubview:line];
    }
    
    _isChosePhotoFromHeaderView = NO;
}

- (void)onItemClicked:(UIButton *)button
{
    if (_isChosePhotoFromHeaderView) {
        if ([self.delegate respondsToSelector:@selector(photoPickerController:didFinishPickingAssets:theOriginal:)]) {
            [self.delegate photoPickerController:self didFinishPickingAssets:_assertArray theOriginal:YES];
        }
        [self dismiss];
    }
    else {
        [self tackPhotoOrChoseFromLib:button.tag];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.topCell;
    }
    else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"CancelCellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] init];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
            cell.textLabel.textColor = [UIColor colorWithRed:0 green:122 / 255.0 blue:1 alpha:1];
        }
        
        cell.layer.cornerRadius = kCTPickerViewCornerRadius;
        cell.layer.masksToBounds = YES;
        
        cell.textLabel.text = @"取消";
        return cell;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        [self dismiss];
    }
}

#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    
    return kCTPickerViewMargin;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return kCTPickerViewHeaderHeight + kCTPickerViewCellHeight * 2;
    }
    return kCTPickerViewCellHeight;
}

#pragma mark - Show & dismiss

- (void)show:(UIViewController *)presentingViewController
{
    NSLog(@"show");
    
    if (!self.view.superview) {
        UIWindow *window = presentingViewController.view.window;
        self.view.bounds = window.bounds;
        [window addSubview:self.view];
        
        [self showViewAnimated:nil];
        
        if (!presentedControllers) {
            presentedControllers = [NSMutableArray array];
        }
        [presentedControllers addObject:self];
    }
}

- (void)dismiss
{
    NSLog(@"dismiss");
    
    UIView *view = self.view;
    typeof(self) __weak weakSelf = self;
    
    [self hideViewAnimated:^(BOOL finished) {
        typeof(self) __strong strongSelf = weakSelf;
        if (strongSelf) {
            [presentedControllers removeObject:strongSelf];
        }
        [view removeFromSuperview];
    }];
}

- (void)showViewAnimated:(void (^)(BOOL finished))completion
{
    CGRect originalFrame = self.tableView.frame;
    CGRect targetFrame = originalFrame;
    
    originalFrame.origin.y += originalFrame.size.height;
    self.tableView.frame = originalFrame;
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:kCTPickerViewAnimatedDuration animations:^{
        weakSelf.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        weakSelf.tableView.frame = targetFrame;
    } completion:completion];
}

- (void)hideViewAnimated:(void (^)(BOOL finished))completion
{
    CGRect originalFrame = self.tableView.frame;
    CGRect targetFrame = originalFrame;
    
    targetFrame.origin.y += originalFrame.size.height;
    
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:kCTPickerViewAnimatedDuration animations:^{
        weakSelf.view.backgroundColor = [UIColor clearColor];
        weakSelf.tableView.frame = targetFrame;
    } completion:completion];
}

#pragma mark - 启动相机或者相册

- (void)tackPhotoOrChoseFromLib:(NSInteger)indexPathRow
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = self.allowsEditing;
    
    if (indexPathRow == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self alertWithTitle:nil andMessage:@"相机不可用" andButtonTitle:@"确定" andButtonTitle:nil];
            return;
        }
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
            [self alertWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相机”选项中，允许友鲸访问你的相机。" andButtonTitle:@"确定" andButtonTitle:nil];
            return;
        }
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (indexPathRow == 1) {
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self alertWithTitle:nil andMessage:@"相册不可用" andButtonTitle:@"确定" andButtonTitle:nil];
            return;
        }
        
        
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
            [self alertWithTitle:nil andMessage:@"请在iPhone的“设置-隐私-相机”选项中，允许友鲸访问你的相册。" andButtonTitle:@"确定" andButtonTitle:nil];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIPickerViewDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if ([self.delegate respondsToSelector:@selector(photoPickerController:didFinishPickingImages:)]) {
        [self.delegate photoPickerController:self didFinishPickingImages:[NSArray arrayWithObject:image]];
    }
    
    typeof(self) __weak weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf dismiss];
    }];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
