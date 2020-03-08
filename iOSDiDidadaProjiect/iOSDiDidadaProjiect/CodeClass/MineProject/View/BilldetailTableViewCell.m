//
//  BilldetailTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BilldetailTableViewCell.h"
#import "AllBillModel.h"

@implementation BilldetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(AllBillModel *)model {
    
    self.nameLab.text = model.name;
    self.priceLab.text = model.money;
    self.stauteLab.text = model.statusName;
}

@end
