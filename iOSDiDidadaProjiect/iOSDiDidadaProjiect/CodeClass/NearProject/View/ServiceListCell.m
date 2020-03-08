//
//  ServiceListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ServiceListCell.h"
#import "GoodsTypeModel.h"

@implementation ServiceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(GoodsTypeModel *)model {
    self.contentLab.text = model.typeName;
    if ([model.tag isEqualToString:@"1"]) {
        self.contentLab.textColor = APPColor;
    } else {
        self.contentLab.textColor = APPGrayColor;
    }
}

@end
