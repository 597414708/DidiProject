//
//  ClassCollectionViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ClassCollectionViewCell.h"
#import "ShopTypeModel.h"
@implementation ClassCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)showData:(ShopTypeModel *)model {
    
    self.contentLab.text = model.name;
    self.contentLab.layer.borderWidth = 1;
    if ([model.select isEqualToString:@"1"]) {
        self.contentLab.layer.borderColor = APPColor.CGColor;
        self.contentLab.textColor = APPColor;
    } else {
        self.contentLab.layer.borderColor = Color(238, 238, 238).CGColor;
        self.contentLab.textColor = APPblackColor;
    }
    
}
@end
