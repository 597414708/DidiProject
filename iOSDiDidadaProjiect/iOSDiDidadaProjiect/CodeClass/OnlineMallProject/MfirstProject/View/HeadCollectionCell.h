//
//  HeadCollectionCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopTypeModel;

@class ListModel;

@interface HeadCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


- (void)showListData:(ListModel *)model;

- (void)showTypeListData:(ShopTypeModel *)model;


@end
