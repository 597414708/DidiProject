//
//  GoodsSecondTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/29.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ParamModel;
@interface GoodsSecondTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *contentName;

- (void)showData:(ParamModel *)model;

@end
