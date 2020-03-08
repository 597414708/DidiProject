//
//  GoodsClassViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsClassViewController.h"
#import "ClassCollectionViewCell.h"
#import "ShopTypeModel.h"

@interface GoodsClassViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;


@end

@implementation GoodsClassViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatCollectionView];
}



- (void)creatCollectionView {
    // Initialization code
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ClassCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ClassCell"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake((TheW *0.75 - 20) / 2.0,  40);
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 5;
    //设置最小行间距
    layOut.minimumLineSpacing = 5;
    layOut.sectionInset = UIEdgeInsetsMake(5,5, 5, 5);
    self.myCollectionView.collectionViewLayout = layOut;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassCell" forIndexPath:indexPath];
    ShopTypeModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (ShopTypeModel *model in self.dataSource) {
        model.select = @"0";
    }
    
    ShopTypeModel *model = self.dataSource[indexPath.row];
    model.select = @"1";
    [self.myCollectionView reloadData];
    [UIView animateWithDuration:0.36 animations:^{
        self.view.frame = CGRectMake(TheW, 0, TheW, TheH);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.myBlock) {
            self.myBlock(model);
        }
        [self.view removeFromSuperview];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-GoodsClassViewController-释放");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
