//
//  AddressOrderCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderCenterModel;

@interface AddressOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *mobileLab;

- (void)showData:(OrderCenterModel *)model;


@end
