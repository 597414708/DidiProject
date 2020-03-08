//
//  HeadCollectionCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "HeadCollectionCell.h"
#import "ListModel.h"
#import "ShopTypeModel.h"

@implementation HeadCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)showListData:(ListModel *)model {
    self.bgImage.layer.cornerRadius = 35.0 / 2;
    self.bgImage.layer.masksToBounds = YES;
    self.bgImage.image = [UIImage imageNamed:model.bgImage];
    self.className.text = model.className;
    self.className.textColor = APPGrayColor;
}


- (void)showTypeListData:(ShopTypeModel *)model {
    self.bgImage.layer.cornerRadius = 35.0 / 2;
    self.bgImage.layer.masksToBounds = YES;
    self.className.text = model.name;
    self.className.textColor = APPGrayColor;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.typeImg] placeholderImage:placeHoder];

}

@end
