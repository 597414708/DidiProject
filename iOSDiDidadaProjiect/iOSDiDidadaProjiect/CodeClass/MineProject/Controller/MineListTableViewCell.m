//
//  MineListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MineListTableViewCell.h"
#import "ListModel.h"

@implementation MineListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showListData:(ListModel *)model {
    self.className.text = model.className;
    self.bgImage.image = [UIImage imageNamed:model.bgImage];

}


@end
