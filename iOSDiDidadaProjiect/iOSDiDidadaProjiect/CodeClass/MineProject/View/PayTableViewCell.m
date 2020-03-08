//
//  PayTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PayTableViewCell.h"
#import "PayTypeModel.h"

@implementation PayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PayTypeModel *)model {
    self.headImage.image = [UIImage imageNamed:model.headImage];
    
    self.contentLab.text = model.content;
    
    if (model.select) {
        self.selectImage.image = [UIImage imageNamed:@"icon_change_s"];
    } else {
        self.selectImage.image = [UIImage imageNamed:@"icon_change_n"];
    }
}

@end
