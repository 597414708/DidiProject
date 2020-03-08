//
//  SecondCollectionViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/20.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTypeModel;

@interface SecondCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


- (void)showData:(HomeTypeModel *)model;
@end
