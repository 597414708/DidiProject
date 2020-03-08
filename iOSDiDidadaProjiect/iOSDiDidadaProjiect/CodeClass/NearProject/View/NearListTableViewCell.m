//
//  NearListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "NearListTableViewCell.h"
#import "ShopModel.h"

@implementation NearListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWith:(ShopModel *)model {

    self.tellLab.text = model.info3;
    self.bgImageView.layer.cornerRadius = 10;
    self.bgImageView.layer.masksToBounds = YES;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
    self.titleLab.text = model.name;
    self.locationLab.text = model.juli;
    self.contentLab.text = model.serviceProject;
}


- (IBAction)navigationAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
    
}




@end
