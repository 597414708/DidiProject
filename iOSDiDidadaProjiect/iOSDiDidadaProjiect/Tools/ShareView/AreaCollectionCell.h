//
//  AreaCollectionCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaModel;
@interface AreaCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;


- (void)showData:(AreaModel *)model;
@end
