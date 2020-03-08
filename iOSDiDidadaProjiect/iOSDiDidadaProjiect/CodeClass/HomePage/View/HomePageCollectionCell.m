//
//  HomePageCollectionCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "HomePageCollectionCell.h"
#import "ShopModel.h"
#import "GoodsModel.h"

@implementation HomePageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showDataWith:(ShopModel *)model {
    self.className.textColor = APPGrayColor;
    self.locationLab.textColor = APPColor;
    self.className.text = model.name;
    self.locationLab.text = model.juli;
    self.bgImage.layer.cornerRadius = 15;
    self.bgImage.clipsToBounds = YES;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
}


- (void)showDataMall:(GoodsModel *)model {
    self.className.textColor = APPGrayColor;
    self.locationLab.textColor = APPColor;
    self.className.text = model.name;
    self.locationLab.text = [NSString stringWithFormat:@"¥ %@", model.price];
    self.bgImage.layer.cornerRadius = 15;
    self.bgImage.clipsToBounds = YES;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImg] placeholderImage:placeHoder];

}
@end
