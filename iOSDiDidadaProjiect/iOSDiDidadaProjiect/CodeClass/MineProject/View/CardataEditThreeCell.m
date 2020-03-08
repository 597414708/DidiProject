//
//  CardataEditThreeCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CardataEditThreeCell.h"
#import "AddressModel.h"
@implementation CardataEditThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showData:(AddressModel *)model {
    self.className.text = model.className;
    if (model.tag == 1) {
        self.selectControl.on = YES;
    } else {
        self.selectControl.on = NO;
    }
}


- (IBAction)selectAction:(UISwitch *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
}



@end
