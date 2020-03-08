//
//  AreaView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AreaView.h"
#import "AreaCollectionCell.h"
#import "AreaModel.h"


@implementation AreaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

+ (AreaView *)shareAreaViewWith:(NSString *)str{
    AreaView *view = [[[NSBundle mainBundle] loadNibNamed:@"AreaView" owner:nil options:nil] firstObject];
    
    view.backgroundColor = [UIColor clearColor];
    
    view.frame = CGRectMake(0, 0, TheW, TheH);
    
    NSArray *areaArray = @[@"京", @"津", @"冀", @"晋", @"沪", @"苏", @"浙", @"皖",
                           @"鄂", @"湘", @"粤", @"桂", @"云", @"藏", @"陕", @"甘",
                           @"蒙", @"辽", @"吉", @"黑", @"闽", @"赣", @"鲁", @"豫",
                           @"琼", @"渝", @"川", @"贵", @"青", @"宁", @"新"]; //@"新车无牌"];
    for (NSString *areaName in areaArray) {
        AreaModel *model = [[AreaModel alloc] init];
        model.areaName = areaName;
        if ([str isEqualToString:areaName]) {
            model.tag = @"1";
        } else {
            model.tag = @"0";
        }
        [view.dataSource addObject:model];
    }

    [view creatShareCollectionView];
    return view;
}


- (void)creatShareCollectionView {

    
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self creatLayOut];

    [self.myCollectionView registerNib:[UINib nibWithNibName:@"AreaCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"AreaCell"];
}

- (void)creatLayOut {
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 0;
    //设置最小行间距
    layOut.minimumLineSpacing = 0;
    //设置item的大小
    layOut.itemSize = CGSizeMake(TheW / 8,  TheW / 8);
    //设置分区上左下右间距
    layOut.sectionInset = UIEdgeInsetsMake(0,0, 0, 0);
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.myCollectionView.collectionViewLayout = layOut;
}

- (IBAction)removeAction:(UITapGestureRecognizer *)sender {
    
    [self removeFromSuperview];
}

#pragma -mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AreaCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AreaCell" forIndexPath:indexPath];
    AreaModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}


#pragma -mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AreaModel *model = self.dataSource[indexPath.row];

    NSString *areaStr = model.areaName;
    if (self.areaBlock) {
        self.areaBlock(areaStr);
    }
    
    [self removeFromSuperview];
    
}

@end
