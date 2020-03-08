//
//  MfirstViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/24.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MfirstViewController.h"
#import "MallHomePageHeadView.h"
#import "HomePageCollectionCell.h"
#import "GoodsListViewController.h"
#import "GoodsDetailViewController.h"

#import "GoodsModel.h"

#import "ShopTypeModel.h"
#import "BanaModel.h"
#import "MallViewController.h"
#import "SearchViewController.h"

@interface MfirstViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (nonatomic, strong) MallHomePageHeadView *headerView;

@property (nonatomic , assign) BOOL isFlag;

@property (nonatomic , assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *typeDataSource;

@end

@implementation MfirstViewController



- (NSMutableArray *)typeDataSource {
    if (!_typeDataSource) {
        self.typeDataSource = [NSMutableArray array];
    }
    return _typeDataSource;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    UIImage *rightImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.navigationController.navigationBar setBackIndicatorImage:rightImage];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:rightImage];
    self.navigationController.navigationBar.tintColor = APPColor;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem];
    
    [self creatShopType];
    [self creatListView];
    
    [self creatUI];
    
    [self creatVisitorsRefresh];
}

- (void)creatUI {

    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, TheW - 60, 30);
    searchButton.backgroundColor = kCOLOR_HEX(0xeeeeee);
    searchButton.layer.cornerRadius = 15;
    searchButton.layer.masksToBounds = YES;
    [searchButton setTitle:@"🔍 搜索商品" forState:UIControlStateNormal];
    [searchButton setTitleColor:APPGrayColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchButton;
}


- (void)creatVisitorsRefresh {
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        weakSelf.isFlag = YES;
        weakSelf.page = 1;
        [weakSelf creatData];
    }];
    
    [header beginRefreshing];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myCollectionView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.myCollectionView.mj_footer = footer;
}


- (void)creatData {
    NSMutableDictionary *muDic = @{@"shopId":@"1",
                                   @"goodsType":@"",
                                   @"pageSize":@"4",
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]
                                   }.mutableCopy;
    [APIManager GetShopGoodslistWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            GoodsModel *model = [[GoodsModel alloc] init];
            model = [GoodsModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        self.page += 1;
        self.isFlag = NO;

        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView.mj_footer endRefreshing];
        [self.myCollectionView reloadData];
        
    } failure:^(NSError *error) {
        [self.myCollectionView.mj_header endRefreshing];
        [self.myCollectionView.mj_footer endRefreshing];
    }];
}

- (void)creatShopType {
    NSMutableDictionary *muDic = @{
                                   @"parent.id":@"1"
                                  }.mutableCopy;
    [APIManager GetShopTypeWithParameters:muDic success:^(id data) {
        
        NSArray *dicArray = data[@"list"];
        
        self.typeDataSource = [ShopTypeModel mj_objectArrayWithKeyValuesArray:dicArray];
        [self.myCollectionView reloadData];

    } failure:^(NSError *error) {
    
    }];
}


- (void)searchAction:(UIButton *)sender {
    SearchViewController *seachVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"SearchVC"];
    seachVC.type = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    MyLog(@"搜索");
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)creatListView {
    //创建layout
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 10;
    //设置最小行间距
    layOut.minimumLineSpacing = 10;
    //设置item的大小
    layOut.itemSize = CGSizeMake((TheW - 30) / 2.0,  (TheW - 30) * 0.9 / 2.0);
    //设置分区上下左右间距
    layOut.sectionInset = UIEdgeInsetsMake(10,10, 10, 10);
    self.myCollectionView.collectionViewLayout = layOut;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCell"];
    self.myCollectionView.backgroundColor = Color(255, 255, 255);
    
    //注册区头
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MallHomePageHeadView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
}


//展示附加视图(区头 和 区尾)
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        self.headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        self.headerView.backgroundColor = [UIColor whiteColor];
        self.headerView.dataSource = self.typeDataSource;
        
        NSMutableArray *arra = [NSMutableArray array];
        for (BanaModel *model in ((MallViewController *)self.tabBarController).secondArray) {
            [arra addObject:model.pic];
        }
        
        self.headerView.photoArr = arra;
        
        
        if (self.headerView.photoArr.count >= 1) {
            [self.headerView.cyleView addSubview:self.headerView.topPhotoBoworr];
        }
        [self.headerView.myCollectionView reloadData];
        WS(weakSelf);
        [self.headerView setMyBlock:^(NSInteger index){
            ShopTypeModel *model = weakSelf.typeDataSource[index];
            GoodsListViewController *goodsListVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsListVC"];
            goodsListVC.type = model.id;
            weakSelf.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:goodsListVC animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
            
        }];
        return  self.headerView;
    } else  {
        return nil;
    }
}

//某个分区的区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(TheW, (TheW * 145/ 375 )+ 45 + (TheW / 2));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(0, 0);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCell" forIndexPath:indexPath];
    [cell showDataMall:self.dataSource[indexPath.row]];
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsDetailViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
    VC.model = self.dataSource[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)dealloc
{
    MyLog(@"-MfirstViewController-释放");
    
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
