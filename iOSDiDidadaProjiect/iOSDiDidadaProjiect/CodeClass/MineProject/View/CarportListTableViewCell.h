//
//  CarportListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CarInforModel;
@interface CarportListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *carNameLab;

@property (weak, nonatomic) IBOutlet UIButton *cheXianbtn;
@property (weak, nonatomic) IBOutlet UIButton *weiguiCXbtn;

@property (nonatomic, copy) void(^deletelnBlock)(UIButton *sender);

@property (nonatomic, copy) void(^cheXianBlock)(UIButton *sender);

@property (nonatomic, copy) void(^chaXunBlock)(UIButton *sender);


- (void)showData:(CarInforModel *)model;
@end
