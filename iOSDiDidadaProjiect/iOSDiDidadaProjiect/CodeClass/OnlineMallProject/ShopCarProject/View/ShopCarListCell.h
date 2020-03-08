//
//  ShopCarListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCarListGoodsModel;
@interface ShopCarListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;


@property (nonatomic, copy) void(^myBlock)(UIButton *sender, BOOL addTag);

@property (nonatomic, copy) void(^selectBlock)(UIButton *sender);

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (void)showData:(ShopCarListGoodsModel *)model;

@end
