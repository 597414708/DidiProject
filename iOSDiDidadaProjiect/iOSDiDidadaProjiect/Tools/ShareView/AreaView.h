//
//  AreaView.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, copy) void(^areaBlock)(NSString *);

+ (AreaView *)shareAreaViewWith:(NSString *)str;

@end
