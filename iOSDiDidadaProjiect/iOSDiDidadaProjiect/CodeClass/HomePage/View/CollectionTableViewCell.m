//
//  CollectionTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CollectionTableViewCell.h"
#import "PriceListModel.h"

@implementation CollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PriceListModel *)model {
    self.firstLab.text = model.name;
    self.secondLab.text = model.baoE;
}
@end
