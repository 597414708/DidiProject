//
//  QuotationListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsurerListmodel;
@class BaodanListModel;

@interface QuotationListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerLin;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIButton *baojiaBtn;
@property (weak, nonatomic) IBOutlet UIButton *hebaoBtn;

@property (nonatomic, copy) void(^myBlock)(UIButton *sender);

- (void)showData:(InsurerListmodel *)model;

- (void)showDataDD:(BaodanListModel *)model;

@end
