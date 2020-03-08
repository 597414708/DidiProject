//
//  PeisongTypeCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
@interface PeisongTypeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)showListData:(ListModel *)model;


@end
