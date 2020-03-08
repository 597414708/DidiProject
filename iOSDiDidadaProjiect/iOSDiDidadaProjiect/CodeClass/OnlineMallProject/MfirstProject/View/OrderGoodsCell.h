//
//  OrderGoodsCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@class OrderCenterGoodsModel;

@interface OrderGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;


- (void)showData:(GoodsModel *)model;

- (void)showDataCenter:(OrderCenterGoodsModel *)model;

@end
