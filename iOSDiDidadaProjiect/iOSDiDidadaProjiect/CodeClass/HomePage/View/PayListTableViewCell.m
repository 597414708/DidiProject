//
//  PayListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PayListTableViewCell.h"
#import "PayTypeModel.h"

@implementation PayListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PayTypeModel *)model {
    
    self.sender.text = model.content;
    self.sender.layer.borderWidth = 1;
    [self ChangeUIWith:model.select];
}

- (void)ChangeUIWith:(BOOL)select {
    if (!select) {
        self.sender.textColor = APPblackColor;
        self.sender.layer.borderColor = kCOLOR_HEX(0xeeeeee).CGColor;
        
    } else {
        self.sender.textColor = APPColor;
        self.sender.layer.borderColor = APPColor.CGColor;
    }
}

@end
