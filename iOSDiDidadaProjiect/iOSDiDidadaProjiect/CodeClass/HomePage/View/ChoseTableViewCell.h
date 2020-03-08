//
//  ChoseTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  CarTypeModel;
@interface ChoseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *baoxianLab;

@property (nonatomic, copy) void(^myBlock)(UIButton *sener);
- (void)showData:(CarTypeModel *)model;
@end
