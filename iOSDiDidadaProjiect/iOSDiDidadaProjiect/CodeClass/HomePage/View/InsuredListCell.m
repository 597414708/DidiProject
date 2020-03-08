//
//  InsuredListCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "InsuredListCell.h"
#import "InsuredModel.h"

@implementation InsuredListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(InsuredModel *)model {
    if ([model.flag isEqualToString:@"1"]) {
        self.bujiView.hidden = NO;
        if (model.tagflag) {
            self.flagBtn.selected = YES;
        } else {
            self.flagBtn.selected = NO;
        }
    } else {
        self.bujiView.hidden = YES;
    }
    
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
    
    if (![model.insuredAmount containsString:@","]) {
        self.moreImage.hidden = YES;
    } else {
        self.moreImage.hidden = NO;
    }
    
    self.contentLab.text  = model.coverageName;
    if (model.price) {
        if ([self isNum:model.price]) {
            self.priceLab.text = [NSString stringWithFormat:@"%@", [self setUnit:model.price]];
        } else {
            self.priceLab.text = [NSString stringWithFormat:@"%@", model.price];
        }
    } else {
        self.priceLab.text = @"";
    }
}

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

//单位
- (NSString *)setUnit:(NSString *)value {
    NSString *strUnit;
    CGFloat priceValue = [value doubleValue];
    
    if (priceValue < 10000) {
        return strUnit = [NSString stringWithFormat:@"%@",  [NSString stringWithFormat:@"%.f元", priceValue]];
    } else {
        strUnit = [NSString stringWithFormat:@"%@%@",  [NSString stringWithFormat:@"%.f", priceValue/10000],@"万"];
    }
    //以下为中国标准显示
    return strUnit;
}

- (IBAction)selectAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock(sender);
    }
    
}

- (IBAction)tapAction:(UIButton *)sender {
    
    if (self.myBlock) {
        self.myBlock(sender);
    }
}

@end
