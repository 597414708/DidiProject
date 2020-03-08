//
//  AddressTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressDataModel;

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (weak, nonatomic) IBOutlet UILabel *telLab;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (nonatomic, copy) void(^deletelnBlock)(UIButton *sender);

@property (nonatomic, copy) void(^selectBlock)(UIButton *sender);

@property (nonatomic, copy) void(^editBlock)(UIButton *sender);

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


- (void)showData:(AddressDataModel *)model;
@end
