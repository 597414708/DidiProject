//
//  ShopCarListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ShopCarListCell.h"
#import "ShopCarListGoodsModel.h"

@implementation ShopCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showData:(ShopCarListGoodsModel *)model {
    self.selectBtn.selected = model.select;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:placeHoder];
    self.titleNameLab.text = model.goodsName;
    self.numLab.text = [NSString stringWithFormat:@"%ld", model.num];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.price];
    
}

- (IBAction)addAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender, sender.tag - 100);
    }
}

- (IBAction)selectAction:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(sender);
    }
}



@end
