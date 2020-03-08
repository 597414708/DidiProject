//
//  StoreHomeListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StoreHomeListCell.h"
#import "GoodsModel.h"
@implementation StoreHomeListCell

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
    self.nameLab.text = model.name;
    
    self.contentLab.text = model.goodsInfo;
    
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", model.price];
    
    
    NSInteger courr = [[StockCodeFMDB shareStockCodeFMDB] searchMessageModelWith:model.id].count;
    self.selectBtn.selected = [[StockCodeFMDB shareStockCodeFMDB] searchMessageModelWith:model.id].count;
}


- (IBAction)addAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
    
}



@end
