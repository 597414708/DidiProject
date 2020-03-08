//
//  SecondCollectionViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/20.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "SecondCollectionViewCell.h"
#import "HomeTypeModel.h"

@implementation SecondCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)showData:(HomeTypeModel *)model {
    self.bgImage.layer.masksToBounds = YES;
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:placeHoder];
    
}
@end
