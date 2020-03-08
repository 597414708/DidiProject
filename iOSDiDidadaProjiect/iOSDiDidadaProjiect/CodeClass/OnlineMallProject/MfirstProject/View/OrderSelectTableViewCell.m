//
//  OrderSelectTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderSelectTableViewCell.h"

@implementation OrderSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(NSString *)str {
    self.contentLab.text = str;
}

@end
