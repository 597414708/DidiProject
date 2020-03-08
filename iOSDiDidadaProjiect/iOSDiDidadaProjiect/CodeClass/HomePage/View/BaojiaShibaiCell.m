//
//  BaojiaShibaiCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaShibaiCell.h"
#import "ListModel.h"

@implementation BaojiaShibaiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(ListModel *)model {
    self.leftLab.text = model.className;
    self.midLab.text = model.content;
    self.rightLab.text = model.state;
}

@end
