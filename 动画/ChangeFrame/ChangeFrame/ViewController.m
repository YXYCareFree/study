//
//  ViewController.m
//  ChangeFrame
//
//  Created by beyondSoft on 16/5/9.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    
    //self.tableView.tableHeaderView = imageView;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (object == _tableView && [keyPath isEqualToString:@"contentOffset"]) {
//        NSLog(@"%@", change[@"new"]);
//    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    _imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 230 - scrollView.contentOffset.y);
    NSLog(@"scrollView%f", scrollView.contentOffset.y);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
