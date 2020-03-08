//
//  CardataEditThreeCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@interface CardataEditThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UISwitch *selectControl;


@property (nonatomic, copy) void(^myBlock)(UISwitch *sender);

-(void)showData:(AddressModel *)model;

@end
