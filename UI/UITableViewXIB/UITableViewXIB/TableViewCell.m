//
//  TableViewCell.m
//  UITableViewXIB
//
//  Created by beyondSoft on 16/4/7.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {

    [super awakeFromNib];

    self.contentView.bounds = [UIScreen mainScreen].bounds;
   
}



- (CGSize)sizeThatFits:(CGSize)size{

    CGFloat totalHeight = 0;

    totalHeight += [self.titleLabel sizeThatFits:size].height;

    return CGSizeMake(size.width, totalHeight + 5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
