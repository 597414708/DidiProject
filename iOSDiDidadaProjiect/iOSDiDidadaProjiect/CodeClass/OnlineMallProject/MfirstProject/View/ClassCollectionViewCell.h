//
//  ClassCollectionViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopTypeModel;
@interface ClassCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)showData:(ShopTypeModel *)model;

@end
