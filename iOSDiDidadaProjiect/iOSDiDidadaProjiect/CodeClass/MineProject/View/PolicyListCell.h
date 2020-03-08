//
//  PolicyListCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/15.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaodanListModel;

@interface PolicyListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;

- (void)showDataDD:(BaodanListModel *)model;

@end
