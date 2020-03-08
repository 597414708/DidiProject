//
//  MyOrderTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "OrderModel.h"
@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWith:(OrderModel *)model {
    self.titleLab.text = model.shopName;
    
    self.dateLab.text = model.startTime;
    
    self.contentLab.text = model.content;

    if (model.status == 0) {
        self.stateLab.text = @"预约中";
        self.cancelBtn.hidden = NO;
        self.cancelBtn.backgroundColor = [UIColor clearColor];
        [self.cancelBtn setImage:[UIImage imageNamed:@"aicon_order"] forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"" forState:UIControlStateNormal];
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    
    } else if (model.status == 1) {
        self.stateLab.text = @"已完成";
        self.cancelBtn.hidden = NO;
        self.cancelBtn.backgroundColor = APPColor;
        [self.cancelBtn setImage:nil forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"评价" forState:UIControlStateNormal];
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }  else if (model.status == 2) {
        
        self.stateLab.text = @"已评价";
        self.cancelBtn.hidden = NO;
        self.cancelBtn.backgroundColor = APPColor;
        [self.cancelBtn setImage:nil forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    } else {
        self.stateLab.text = @"已取消";
        self.cancelBtn.hidden = NO;
        self.cancelBtn.backgroundColor = APPColor;
        [self.cancelBtn setImage:nil forState:UIControlStateNormal];
        [self.cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.shopLogo] placeholderImage:placeHoder];
}


- (IBAction)tapAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}

@end
