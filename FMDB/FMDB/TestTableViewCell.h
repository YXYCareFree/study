//
//  TestTableViewCell.h
//  FMDB
//
//  Created by beyondSoft on 16/8/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestModel;

@interface TestTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

- (void)configModel:(TestModel *)model;

@end
