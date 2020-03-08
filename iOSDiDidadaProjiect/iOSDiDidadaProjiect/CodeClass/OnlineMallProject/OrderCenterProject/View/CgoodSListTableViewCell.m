//
//  CgoodSListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/26.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CgoodSListTableViewCell.h"
#import "OrderCenterGoodsModel.h"

@implementation CgoodSListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(OrderCenterGoodsModel *)model {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:placeHoder];
    self.titleNameLab.text = model.goodsName;
    self.numLab.text = [NSString stringWithFormat:@"%ld", model.number];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.goodsMoney];
    
}


@end
