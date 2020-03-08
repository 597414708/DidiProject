//
//  CarportListTableViewCell.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarportListTableViewCell.h"
#import "CarInforModel.h"

@implementation CarportListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(CarInforModel *)model {
    [self clispViewWith:self.cheXianbtn];
    [self clispViewWith:self.weiguiCXbtn];
    self.carNameLab.text = [NSString stringWithFormat:@"%@ %@", model.brand,model.licenseNo];
}

- (void)clispViewWith:(UIView *)sender {
    sender.layer.cornerRadius = 2;
    sender.layer.masksToBounds = YES;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = APPColor.CGColor;
}

- (IBAction)deleteBtn:(UIButton *)sender {
    if (self.deletelnBlock) {
        self.deletelnBlock(sender);
    }
    
}

- (IBAction)cheXianAction:(UIButton *)sender {
    if (self.cheXianBlock) {
        self.cheXianBlock(sender);
    }

}


- (IBAction)chaxunAction:(UIButton *)sender {
    if (self.chaXunBlock) {
        self.chaXunBlock(sender);
    }

}



@end
