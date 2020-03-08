//
//  AddressTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressDataModel.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(AddressDataModel *)model {
    self.editBtn.layer.cornerRadius = 2;
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = APPGrayColor.CGColor;
    
    self.nameLab.text = model.name;
    self.telLab.text = model.mobile;
    self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", model.province, model.city, model.country, model.address];
    
    self.selectBtn.selected = model.isdef;
    
    
    
}

- (IBAction)selectAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.selectBlock) {
        self.selectBlock(sender);
    }
}

- (IBAction)editAction:(UIButton *)sender {
    if (self.editBlock) {
        self.editBlock(sender);
    }
}

- (IBAction)deleteAction:(UIButton *)sender {
    if (self.deletelnBlock) {
        self.deletelnBlock(sender);
    }
}

@end
