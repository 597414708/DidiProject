//
//  BaojiaListCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/30.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsurerListmodel;

@interface BaojiaListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIButton *baojiaBtn;

@property (copy, nonatomic) void(^myBlock)(UIButton *sender);

- (void)showData:(InsurerListmodel *)model;
@end
