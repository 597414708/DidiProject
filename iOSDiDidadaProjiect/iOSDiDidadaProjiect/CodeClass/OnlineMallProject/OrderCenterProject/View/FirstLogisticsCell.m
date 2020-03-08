//
//  FirstLogisticsCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/16.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "FirstLogisticsCell.h"
#import "PostListModel.h"

@implementation FirstLogisticsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)typeWith:(NSInteger)type With:(PostListModel *)model {
    
    self.dateLab.text = model.time;
    self.contentLab.text = model.context;
    switch (type) {
        case 0:
        {
            self.tagImage.image = [UIImage imageNamed:@"icon_wlxq_new_s"];
            self.topLab.hidden = YES;
            self.bottomLab.hidden = NO;
            self.contentLab.textColor = Color(255,116,62);
        }
            break;
        case 1:
        {
            self.tagImage.image = [UIImage imageNamed:@"icon_wlxq_new_n"];
            self.topLab.hidden = NO;
            self.bottomLab.hidden = NO;
            self.contentLab.textColor = APPGrayColor;
        }
            break;
            
        case 2:
        {
            self.tagImage.image = [UIImage imageNamed:@"icon_wlxq_new_n"];
            self.topLab.hidden = NO;
            self.bottomLab.hidden = YES;
            self.contentLab.textColor = APPGrayColor;
            
        }
            break;
   
        case 3:
        {
            self.tagImage.image = [UIImage imageNamed:@"icon_wlxq_new_s"];
            self.topLab.hidden = YES;
            self.bottomLab.hidden = YES;
            self.contentLab.textColor = Color(255,116,62);
            
        }
            break;
            
        default:
            break;
    }
}

@end
