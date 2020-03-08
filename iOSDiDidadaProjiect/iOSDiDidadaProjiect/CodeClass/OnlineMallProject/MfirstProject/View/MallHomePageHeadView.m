//
//  HomePageHeadView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MallHomePageHeadView.h"
#import "HeadCollectionCell.h"
#import "ShopTypeModel.h"

#define Screen_Width  [UIScreen mainScreen].bounds.size.width

@interface MallHomePageHeadView ()<SDCycleScrollViewDelegate>


@end

@implementation MallHomePageHeadView

- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, TheW, (TheW * 145/ 375 ) - 5) delegate:self placeholderImage:nil];
//        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 60;
        //self.view.userInteractionEnabled
        //_topPhotoBoworr.autoScroll = NO;
        
        _topPhotoBoworr.currentPageDotImage = [UIImage imageNamed:@"pic_bani_s"];
        _topPhotoBoworr.pageDotImage = [UIImage imageNamed:@"pic_bani_n"];
        _topPhotoBoworr.imageURLStringsGroup = self.photoArr;
    }
    return _topPhotoBoworr;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HeadCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellS"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(TheW / 4, TheW / 4);
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 0;
    //设置最小行间距
    layOut.minimumLineSpacing = 0;
    
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCollectionView.collectionViewLayout = layOut;

}



#pragma -mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellS" forIndexPath:indexPath];
    ShopTypeModel *model = self.dataSource[indexPath.row];
    [cell showTypeListData:model];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.myBlock) {
        self.myBlock(indexPath.row);
    }
}

@end
