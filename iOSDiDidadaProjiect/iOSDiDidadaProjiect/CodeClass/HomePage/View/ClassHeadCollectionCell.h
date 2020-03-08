//
//  ClassHeadCollectionCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
@interface ClassHeadCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


- (void)showListData:(ListModel *)model;
@end
