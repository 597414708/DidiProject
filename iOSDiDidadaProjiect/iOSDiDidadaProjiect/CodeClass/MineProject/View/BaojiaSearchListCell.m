//
//  BaojiaSearchListCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/17.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaSearchListCell.h"
#import "BaojiaSearchModel.h"

@implementation BaojiaSearchListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(BaojiaSearchModel *)model {
    NSDictionary *postparamDic = [self dictionaryWithJsonString:model.postparam];
    self.modleName.text = [postparamDic objectForKey:@"MoldName"];
    self.numLab.text = model.licenseNo;
    self.dateLab.text = model.createDate;
    self.sourceName.text = model.sourceName;
    if ([model.quoteStatus isEqualToString:@"1"]) {
        self.midleLab.textColor = APPColor;
        self.midleLab.text = [NSString stringWithFormat:@"¥%@", model.totalPrice];
    } else if ([model.quoteStatus isEqualToString:@"-1"]){
        self.midleLab.textColor = kCOLOR_HEX(0xFF743E);
        self.midleLab.text = [NSString stringWithFormat:@"等待报价"];
    } else {
        self.midleLab.textColor = kCOLOR_HEX(0xFF743E);
        self.midleLab.text = [NSString stringWithFormat:@"报价失败"];
    }
    
    if ([model.businessStatus isEqualToString:@"1"]) {
        self.rightLab.text = @"已核保";
    } else {
        self.rightLab.text = @"未核保";
    }
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
