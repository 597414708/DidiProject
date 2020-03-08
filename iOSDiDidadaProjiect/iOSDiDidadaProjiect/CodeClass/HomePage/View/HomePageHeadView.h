//
//  HomePageHeadView.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface HomePageHeadView : UICollectionReusableView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIView *cyleView;

@property (nonatomic, copy) void(^myBlock)(NSInteger index);

@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;

@property (nonatomic, strong) NSMutableArray *photoArr;


@end
