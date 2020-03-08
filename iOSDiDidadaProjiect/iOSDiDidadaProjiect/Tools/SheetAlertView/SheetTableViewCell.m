//
//  SheetTableViewCell.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SheetTableViewCell.h"

@implementation SheetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(NSDictionary *)dic {
    self.contentLabel.text = dic[@"content"];
    self.contentLabel.textColor = dic[@"color"];
}

@end
