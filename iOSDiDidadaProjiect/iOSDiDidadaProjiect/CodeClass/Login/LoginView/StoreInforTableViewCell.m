//
//  StoreInforTableViewCell.m
//  IOSSumgoTeaProject
//
//  Created by 敲代码mac1号 on 16/11/7.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "StoreInforTableViewCell.h"

@implementation StoreInforTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)choseImage:(UIButton *)sender {
    if (self.choseImageBlock) {
        self.choseImageBlock(sender);
    }
    
}

@end
