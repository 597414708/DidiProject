//
//  StoreCommentCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StoreCommentCell.h"
#import "CommentModel.h"

@implementation StoreCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)showDataWith:(CommentModel *)model {
    self.headImage.layer.cornerRadius = 23;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.userHead] placeholderImage:placeHoder];
    self.contentLab.text = model.content;
    self.nameLab.text = model.userName;

}

@end
