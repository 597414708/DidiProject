//
//  CardataEditOneCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CardataEditOneCell.h"
#import "AddressModel.h"

@implementation CardataEditOneCell

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
    NSString *content = [model.content substringToIndex:1];
    NSString *text = [model.content substringFromIndex:1];
    self.contentTf.text = text;
    self.contentLab.text = content;
    if (model.tag == 1) {
        self.contentTf.enabled = YES;
    } else {
        self.contentTf.enabled = NO;
        self.contentTf.text = model.content;        
    }
    
}

- (IBAction)senderAction:(UIButton *)sender {
    if (self.areaBlock) {
        self.areaBlock();
    }
}



@end
