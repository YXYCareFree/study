//
//  ViewController.m
//  Reader
//
//  Created by beyondSoft on 16/8/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <QuickLook/QuickLook.h>

@interface ViewController ()<QLPreviewControllerDelegate, QLPreviewControllerDataSource>

@property (nonatomic, strong) QLPreviewController * preview;

@property (nonatomic, strong) NSArray * pathArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.preview = [[QLPreviewController alloc] init];
    self.preview.view.frame = self.view.bounds;
    self.preview.delegate = self;
    self.preview.dataSource = self;
    [self presentViewController:self.preview animated:YES completion:nil];

     NSString * path1 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
     NSString * path2 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"docx"];

    NSArray * arr = @[path1, path2];
    _pathArr = arr;

}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return _pathArr.count;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{


    return [NSURL fileURLWithPath:_pathArr[index]];
}


@end
