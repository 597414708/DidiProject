//
//  PersonalDataTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PersonalDataTableViewCell.h"
#import "PersonDataModel.h"

@implementation PersonalDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PersonDataModel *)model {
    self.classLab.text = model.className;
    self.contentLab.text = model.content;
    
}

@end
