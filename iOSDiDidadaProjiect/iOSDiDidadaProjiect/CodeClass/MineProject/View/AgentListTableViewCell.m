//
//  AgentListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "AgentListTableViewCell.h"
#import "AgentModel.h"

@implementation AgentListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgImage.layer.cornerRadius = 20;
    self.bgImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(AgentModel *)model {
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.userHead] placeholderImage:placeHoder];
    self.nameLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"¥%@", model.totalMoney];
    self.timeLab.text = [NSString stringWithFormat:@"%@笔", model.number];
//    if(model.level){
//        self.moreImage.hidden = NO;
//    } else {
//        self.moreImage.hidden = YES;
//
//    }
}

@end
