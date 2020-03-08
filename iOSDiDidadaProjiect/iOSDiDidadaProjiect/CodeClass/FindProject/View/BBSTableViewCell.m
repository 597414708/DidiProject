//
//  BBSTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BBSTableViewCell.h"
#import "ArticleListModel.h"

@implementation BBSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(ArticleListModel *)model {
    
    self.bgImage.layer.masksToBounds = YES;
    
    self.headImage.layer.cornerRadius = 15;
    
    self.headImage.layer.masksToBounds = YES;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.createHead] placeholderImage:placeHoder];
    
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:model.indexImg] placeholderImage:placeHoder];

    self.titleLable.text = model.title;
    
}

@end
