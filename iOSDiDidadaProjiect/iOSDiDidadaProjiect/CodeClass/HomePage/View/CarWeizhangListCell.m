//
//  CarWeizhangListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarWeizhangListCell.h"
#import "WeizhangModel.h"
@implementation CarWeizhangListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(WeizhangModel *)model{
    self.contentLab.text = model.area;
    
    if ([model.handled isEqualToString:@"1"]) {
        self.stateLab.text = @"已处理";
        self.stateLab.textColor = APPColor;
    } else {
        self.stateLab.text = @"未处理";
        self.stateLab.textColor = kCOLOR_HEX(0xFF743E);
    }
}
@end
