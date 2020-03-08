//
//  SelectAddressCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "SelectAddressCell.h"
#import "AddressDataModel.h"
#import "OrderCenterModel.h"

@implementation SelectAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(AddressDataModel *)model {
    self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", model.province, model.city, model.country, model.address];
}

- (void)showPost:(NSString *)model {
    self.bgImage.image = [UIImage imageNamed:@"icon_exp"];
    self.addressLab.textColor = kCOLOR_HEX(0xFF743E);
    if (model) {
        self.addressLab.text = model;

    } else {
        self.addressLab.text = @"暂未发货";
    }
}

@end
