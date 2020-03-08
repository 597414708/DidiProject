//
//  BillsTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillListModel;
@interface BillsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

- (void)showData:(BillListModel *)model;

@end
