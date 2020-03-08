//
//  CardataEditTwoCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CardataEditTwoCell.h"
#import "AddressModel.h"
@implementation CardataEditTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(AddressModel *)model {
    self.className.text = model.className;
    self.contentTf.placeholder = model.placeholdStr;
    if (model.tag == 1) {
        self.contentTf.enabled = YES;
    } else {
        self.contentTf.enabled = NO;
    }
    self.contentTf.text = model.content;

}

@end
