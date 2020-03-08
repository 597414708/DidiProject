//
//  BillsTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BillsTableViewCell.h"
#import "BillListModel.h"

@implementation BillsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(BillListModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.info3] placeholderImage:placeHoder];
    self.headImage.layer.masksToBounds = YES;
    self.nameLab.text = model.info2;
    self.priceLab.text = model.payMoney;
}
@end
