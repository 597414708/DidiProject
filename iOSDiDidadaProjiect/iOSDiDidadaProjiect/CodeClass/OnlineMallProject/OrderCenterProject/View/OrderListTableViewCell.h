//
//  OrderListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderCenterModel;

@interface OrderListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *orderNum;

@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UIButton *delateBtn;


@property (nonatomic, copy) void(^commentBlock)(UIButton *sender);

@property (nonatomic, copy) void(^delateBlock)(UIButton *sender);


- (void)showData:(OrderCenterModel *)model;

@end
