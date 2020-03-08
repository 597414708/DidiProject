//
//  BaojiaListCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/30.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaListCell.h"
#import "InsurerListmodel.h"
@implementation BaojiaListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(InsurerListmodel *)model {
    self.priceLab.textColor = kCOLOR_HEX(0xFF743E);
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
    self.nameLab.text = model.name;
    if ([model.selectII isEqualToString:@"1"]) {
        self.stateLab.text = @"核保中";
    } else {
        self.stateLab.text = @"未勾选核保";
    }
    if (model.statusMessage) {
        if ([model.selectII isEqualToString:@"1"]) {
            self.stateLab.text = model.submitResult;
            if (model.submitResult.length > 10) {
                self.stateLab.text = @"核保失败";
            }
        }
        self.baojiaBtn.hidden = YES;
        if (model.quoteStatus.integerValue > 0) {
            self.priceLab.textColor = APPColor;
            float sum =  [model.bizTotal floatValue] + [model.taxTotal floatValue] + [model.forceTotal floatValue];
            self.priceLab.text = [NSString stringWithFormat:@"¥%.2f", sum];
            self.moreLab.text = @"报价详情";
        } else {
            self.priceLab.text = @"报价失败";
            self.priceLab.textColor = kCOLOR_HEX(0xFF743E);
            if (model.quoteStatus.integerValue == -1) {
                self.priceLab.text = @"等待审核";
                self.priceLab.textColor = kCOLOR_HEX(0xFF743E);
            }
        }
    } else {
        self.baojiaBtn.hidden = NO;
        self.priceLab.text = @"一";
        self.priceLab.textColor = kCOLOR_HEX(0xFF743E);
    }
}

- (IBAction)baojiaAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}

@end
