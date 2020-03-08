//
//  AddressOrderCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AddressOrderCell.h"
#import "OrderCenterModel.h"
@implementation AddressOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(OrderCenterModel *)model {
    self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", model.province, model.city, model.country, model.address];
    self.nameLab.text = model.receiveName;
    self.mobileLab.text = model.receiveMobile;
}


@end
