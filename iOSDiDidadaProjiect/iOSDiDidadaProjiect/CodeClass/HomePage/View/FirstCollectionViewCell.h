//
//  FirstCollectionViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/20.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeTypeModel;
@interface FirstCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

- (void)showData:(HomeTypeModel *)model;
@end
