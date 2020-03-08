//
//  OrderGoodsCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderGoodsCell.h"
#import "GoodsModel.h"

#import "OrderCenterGoodsModel.h"

@implementation OrderGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(GoodsModel *)model {
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:placeHoder];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.price];
    self.nameLab.text = model.name;
    if (!model.num) {
        model.num = 1;
    }
    self.countLab.text = [NSString stringWithFormat:@"X %ld", model.num];
    
    
}


- (void)showDataCenter:(OrderCenterGoodsModel *)model {
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:placeHoder];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.goodsMoney];
    self.nameLab.text = [NSString stringWithFormat:@"%@", model.goodsName];
   
    self.countLab.text = [NSString stringWithFormat:@"X %ld", model.number];
    
    
}


@end
