//
//  CgoodSListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/26.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderCenterGoodsModel;
@interface CgoodSListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
- (void)showData:(OrderCenterGoodsModel *)model;

@end
