//
//  AreaCollectionCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AreaCollectionCell.h"
#import "AreaModel.h"
@implementation AreaCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)showData:(AreaModel *)model {
    
    if ([model.tag isEqualToString:@"0"]) {
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.contentLab.textColor = APPblackColor;
    } else {
        self.bgView.backgroundColor = APPColor;
        self.contentLab.textColor = [UIColor whiteColor];
    }
    
    if (model.areaName.length == 1) {
        self.contentLab.font = [UIFont systemFontOfSize:15];
    } else {
        self.contentLab.font = [UIFont systemFontOfSize:10];
    }

    self.bgView.layer.cornerRadius = 2;
    self.bgView.layer.masksToBounds = YES;
    
    
    self.contentLab.text = model.areaName;


}

@end
