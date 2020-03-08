//
//  PolicyListCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/15.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "PolicyListCell.h"
#import "BaodanListModel.h"

@implementation PolicyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)showDataDD:(BaodanListModel *)model {
    
    NSDictionary *dic = @{@"-1":@"审核失败",
                          @"0":@"待审核",
                          @"1":@"待支付",
                          @"2":@"分期中",
                          @"3":@"已完成"
                          };
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.info3] placeholderImage:placeHoder];
    self.titleLab.text = [NSString stringWithFormat:@"%@", model.info2];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@        %@",  model.totalMoney, dic[model.status]];
    self.priceLab.textColor = APPColor;
}
@end
