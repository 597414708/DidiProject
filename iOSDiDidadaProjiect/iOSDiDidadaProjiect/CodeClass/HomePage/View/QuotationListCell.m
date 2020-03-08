//
//  QuotationListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "QuotationListCell.h"
#import "InsurerListmodel.h"
#import "BaodanListModel.h"
@implementation QuotationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(InsurerListmodel *)model {
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
    self.titleLab.text = model.name;
    self.priceLab.textColor = APPColor;
    if ([model.select isEqualToString:@"1"]) {
        self.baojiaBtn.selected = YES;
    } else {
        self.baojiaBtn.selected = NO;
    }
    if ([model.selectII isEqualToString:@"1"]) {
        self.hebaoBtn.selected = YES;
    } else {
        self.hebaoBtn.selected = NO;
    }
}

- (void)showDataDD:(BaodanListModel *)model {
    NSDictionary *dic = @{
                          @"-1":@"审核失败",
                          @"0":@"待审核",
                          @"1":@"待支付",
                          @"2":@"分期中",
                          @"3":@"已完成"
                          };
    self.bgImage.image = [UIImage imageNamed:model.info5];
    self.titleLab.text = [NSString stringWithFormat:@"%@保险", model.insurerName];
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@        %@",  model.totalMoney, dic[model.status]];
    self.priceLab.textColor = APPColor;
}


- (IBAction)tapAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}

@end
