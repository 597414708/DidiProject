//
//  PayListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayTypeModel;
@interface PayListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sender;

- (void)showData:(PayTypeModel *)model;

@end
