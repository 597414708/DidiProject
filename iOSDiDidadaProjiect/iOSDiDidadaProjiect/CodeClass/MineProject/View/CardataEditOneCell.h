//
//  CardataEditOneCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface CardataEditOneCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;

@property (weak, nonatomic) IBOutlet UITextField *contentTf;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (nonatomic, copy) void(^areaBlock)();

- (void)showData:(AddressModel *)model;
@end
