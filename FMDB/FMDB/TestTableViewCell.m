//
//  TestTableViewCell.m
//  FMDB
//
//  Created by beyondSoft on 16/8/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestModel.h"

@implementation TestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configModel:(TestModel *)model{

    self.nameLabel.text = model.name;
    self.ageLabel.text = [NSString stringWithFormat:@"年龄：%d", model.age];
    self.descriptionLabel.text = model.Description;
}

- (IBAction)collectClicked:(id)sender {

    dispatch_queue_t queue = dispatch_queue_create("queue1", NULL);
    dispatch_async(queue, ^{

        TestModel * model = [TestModel new];
        model.name = self.nameLabel.text;
        model.age = [self.ageLabel.text intValue];
        model.Description = self.descriptionLabel.text;

        [model save];
    });
    
}

- (CGSize)sizeThatFits:(CGSize)size{

    CGFloat totalH;

    totalH += [self.nameLabel sizeThatFits:size].height;
    totalH += [self.ageLabel sizeThatFits:size].height;
    totalH += [self.descriptionLabel sizeThatFits:size].height;

    return CGSizeMake(size.width, totalH + 10);

}
@end
