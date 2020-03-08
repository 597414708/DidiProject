//
//  ClassHeadCollectionCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ClassHeadCollectionCell.h"
#import "ListModel.h"

@implementation ClassHeadCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showListData:(ListModel *)model {
    self.bgImage.layer.cornerRadius = 55.0 / 2;
    self.bgImage.layer.masksToBounds = YES;
    self.bgImage.image = [UIImage imageNamed:model.bgImage];
    self.className.text = model.className;
    self.className.textColor = APPGrayColor;
    
    self.className.text = model.className;
    self.bgImage.image = [UIImage imageNamed:model.bgImage];
}

@end
