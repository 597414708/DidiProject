//
//  MineListTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;

@interface MineListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;

- (void)showListData:(ListModel *)model;

@end
