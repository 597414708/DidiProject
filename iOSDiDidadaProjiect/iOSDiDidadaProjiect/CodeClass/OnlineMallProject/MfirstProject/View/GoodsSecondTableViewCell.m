//
//  GoodsSecondTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/29.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsSecondTableViewCell.h"
#import "ParamModel.h"

@implementation GoodsSecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(ParamModel *)model {
    self.className.text = model.paramName;
    self.contentName.text = model.paramValue;
    
}
@end
