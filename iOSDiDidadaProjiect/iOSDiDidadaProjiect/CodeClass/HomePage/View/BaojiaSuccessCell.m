//
//  BaojiaSuccessCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/13.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaSuccessCell.h"
#import "PriceListModel.h"

@implementation BaojiaSuccessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(PriceListModel *)model index:(NSIndexPath *)index {
    self.leftLab.text = model.name;
    self.downImage.hidden = YES;
    if (index.section == 1) {
        if (index.row == 0) {
            self.downImage.hidden = NO;
        }
    }
    if (index.section == 2) {
        if (index.row == 1) {
            self.rightLab.textAlignment = NSTextAlignmentLeft;
            self.rightLab.text = [NSString stringWithFormat:@"%@", model.baoFei];
        } else {
            self.rightLab.textAlignment = NSTextAlignmentRight;
            self.rightLab.text = [NSString stringWithFormat:@"¥%@", model.baoFei];
        }
    } else {
        self.rightLab.textAlignment = NSTextAlignmentRight;
        self.rightLab.text = [NSString stringWithFormat:@"¥%@", model.baoFei];
    }
}
@end
