//
//  ChoseTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ChoseTableViewCell.h"
#import "CarTypeModel.h"

@implementation ChoseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showData:(CarTypeModel *)model {
    if ([model.select isEqualToString:@"2"]) {
        self.selectBtn.hidden = YES;
    } else {
        self.selectBtn.hidden = NO;
    }
    if ([model.select isEqualToString:@"0"]) {
        self.selectBtn.selected = NO;
    } else {
        self.selectBtn.selected = YES;
    }
    //familyName parentVehName engineDesc gearboxType
    self.contentLab.text  = [NSString stringWithFormat:@"%@ %@ %@ %@/%@ %@/%@", model.vehicleNo, model.vehicleName, model.vehicleAlias, model.vehicleExhaust, model.vehicleSeat, model.purchasePrice, model.vehicleYear];
    self.baoxianLab.text = [NSString stringWithFormat:@"(%@)", model.sourceName];
}

- (IBAction)selectAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}

@end
