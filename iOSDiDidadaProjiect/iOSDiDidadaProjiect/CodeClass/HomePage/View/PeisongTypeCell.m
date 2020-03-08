//
//  PeisongTypeCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "PeisongTypeCell.h"
#import "ListModel.h"

@implementation PeisongTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentLab.layer.cornerRadius = 16;
    self.contentLab.layer.masksToBounds = YES;
}

- (void)showListData:(ListModel *)model {
    self.contentLab.text = model.className;
    if ([model.state isEqualToString:@"0"]) {
        self.contentLab.backgroundColor = kCOLOR_HEX(0XEEEEEE);
        self.contentLab.textColor = kCOLOR_HEX(0X666666);

    } else {
        self.contentLab.backgroundColor = APPColor;
        self.contentLab.textColor = [UIColor whiteColor];
    }
    
}
@end
