//
//  ServiceListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsTypeModel;

@interface ServiceListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)showData:(GoodsTypeModel *)model;
@end
