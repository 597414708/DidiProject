//
//  HomePageCollectionCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopModel;
@class GoodsModel;
@interface HomePageCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@property (weak, nonatomic) IBOutlet UILabel *className;


@property (weak, nonatomic) IBOutlet UILabel *locationLab;

- (void)showDataWith:(ShopModel *)model;

- (void)showDataMall:(GoodsModel *)model;
@end
