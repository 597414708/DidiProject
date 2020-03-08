//
//  HomePageHeadView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "HomePageHeadView.h"
#import "ClassHeadCollectionCell.h"
#import "ListModel.h"

#define Screen_Width  [UIScreen mainScreen].bounds.size.width

@interface HomePageHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomePageHeadView

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
        _topPhotoBoworr.imageURLStringsGroup = self.photoArr.mutableCopy;
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
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ClassHeadCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellS"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(TheW / 4, 120);
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 0;
    //设置最小行间距
    layOut.minimumLineSpacing = 0;
    
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myCollectionView.collectionViewLayout = layOut;
    
    [self creatData];
}

- (void)creatData {
    
    ListModel *model1 = [[ListModel alloc] init];
    model1.className = @"线上商城";
    model1.bgImage = @"icon_addcar";
    
    
    ListModel *model2 = [[ListModel alloc] init];
    model2.className = @"车险分期";
    model2.bgImage = @"icon_carins";
    
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = @"违章查询";
    model3.bgImage = @"icon_traffic";
    
    
    ListModel *model4 = [[ListModel alloc] init];
    model4.className = @"共享车位";
    model4.bgImage = @"icon_stopmoney";
    
    [self.dataSource addObject:model1];
    
    [self.dataSource addObject:model2];

    [self.dataSource addObject:model3];

    [self.dataSource addObject:model4];

}


#pragma -mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassHeadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellS" forIndexPath:indexPath];
    ListModel *model = self.dataSource[indexPath.row];
    [cell showListData:model];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.myBlock) {
        self.myBlock(indexPath.row);
    }
}

@end
