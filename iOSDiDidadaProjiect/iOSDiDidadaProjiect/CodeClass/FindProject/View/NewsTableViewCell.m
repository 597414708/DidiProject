//
//  NewsTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "ArticleListModel.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(ArticleListModel *)model {
    
    self.bgImageView.layer.masksToBounds = YES;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.indexImg] placeholderImage:placeHoder];
    
    self.titleLab.text = model.title;
    self.contentLab.text = model.intro;
}


@end
