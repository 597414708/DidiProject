//
//  CarWeizhangListCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeizhangModel;

@interface CarWeizhangListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (weak, nonatomic) IBOutlet UIImageView *moreImage;

- (void)showData:(WeizhangModel *)model;

@end
