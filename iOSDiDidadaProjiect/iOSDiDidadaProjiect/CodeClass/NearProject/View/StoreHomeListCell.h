//
//  StoreHomeListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface StoreHomeListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;


@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic, copy) void(^myBlock)(UIButton *sender);

- (void)showData:(GoodsModel *)model;

@end
