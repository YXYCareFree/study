//
//  CTPickerViewController.h
//  Pods
//
//  Created by 冯增亮 on 16/2/22.
//
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>

@protocol CTPickerViewControllerDelegate <NSObject>

//选取照片回调
- (void)photoPickerController:(id)picker didFinishPickingAssets:(NSArray *)assets theOriginal:(BOOL)theOriginal;

//拍照片回调
- (void)photoPickerController:(id)picker didFinishPickingImages:(NSArray *)images;

@end

//!!!必须调用show显示，调用dismiss关闭。不应该暴露viewController，后续改为类似alertView, actionSheet API方式

@interface CTPickerViewController : UIViewController

@property (nonatomic, assign) BOOL allowsEditing;

@property (nonatomic, assign) BOOL allowsMultiple;

@property(assign,nonatomic) id<CTPickerViewControllerDelegate> delegate;

- (void)show:(UIViewController *)presentingViewController;

- (void)dismiss;

@end