//
//  SelectIndexCell.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/23.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "SelectIndexCell.h"

@implementation SelectIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSDictionary *sedic = [NSDictionary dictionaryWithObjectsAndKeys:APPColor,NSForegroundColorAttributeName,nil];
    NSDictionary *nodic = [NSDictionary dictionaryWithObjectsAndKeys:kCOLOR_HEX(0x999999),NSForegroundColorAttributeName,nil];
    [self.mySeg setTitleTextAttributes:nodic forState:UIControlStateNormal];
    
    [self.mySeg setTitleTextAttributes:sedic forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showData:(NSInteger)index {
    if (index == 0) {
        self.firstLab.hidden = NO;
        self.secondLab.hidden = YES;
    } else {
        self.firstLab.hidden = YES;
        self.secondLab.hidden = NO;
    }
}

- (IBAction)selectIndex:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.firstLab.hidden = NO;
        self.secondLab.hidden = YES;
    } else {
        self.firstLab.hidden = YES;
        self.secondLab.hidden = NO;
    }
    
    if (self.myBlock) {
        self.myBlock(sender.selectedSegmentIndex);
        
    }
}



@end
