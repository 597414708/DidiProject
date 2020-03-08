//
//  NearListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopModel;

@interface NearListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *tellLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *locationLab;


@property (nonatomic, copy) void(^myBlock)(UIButton *sender);

- (void)showDataWith:(ShopModel *)model;
@end
