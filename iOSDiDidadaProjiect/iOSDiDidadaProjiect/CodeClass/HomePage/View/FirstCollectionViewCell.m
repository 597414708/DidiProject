//
//  FirstCollectionViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/20.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "HomeTypeModel.h"
@implementation FirstCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showData:(HomeTypeModel *)model {
    self.bgImage.layer.cornerRadius = 8;
    self.bgImage.layer.masksToBounds = YES;
    self.bgImage.layer.borderColor = kCOLOR_HEX(0xeeeeee).CGColor;
    self.bgImage.layer.borderWidth = 1;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
    self.nameLab.text = model.title;
}

@end
