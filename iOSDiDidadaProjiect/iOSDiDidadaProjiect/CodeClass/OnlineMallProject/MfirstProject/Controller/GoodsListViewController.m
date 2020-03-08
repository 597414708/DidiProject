//
//  GoodsListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsListViewController.h"
#import "HomePageCollectionCell.h"
#import "GoodsClassViewController.h"
#import "GoodsDetailViewController.h"

#import "GoodsModel.h"
#import "ShopTypeModel.h"
#import "SearchViewController.h"

@interface GoodsListViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    NSInteger btnTyp;
}


@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) GoodsClassViewController *goodClassVC;
@property (weak, nonatomic) IBOutlet UIView *mybgView;
@property (weak, nonatomic) IBOutlet UIImageView *salesTypeImage;

@property (nonatomic, strong) NSMutableArray *typeDataSource;



@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;

@property (nonatomic, copy) NSString *goodsType;

@property (nonatomic, copy) NSString *orderBy;


@end

@implementation GoodsListViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)typeDataSource {
    if (!_typeDataSource) {
        self.typeDataSource = [NSMutableArray array];
    }
    return _typeDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderBy = @"";
    self.goodsType = @"";
    // Do any additional setup after loading the view.
    [self creatCollectionView];
    [self creatUI];
    [self creatTypeData];
    [self creatVisitorsRefresh];
    btnTyp = 0;
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
    NSMutableDictionary *muDic = @{
                                   @"parent.id":self.goodsType,
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page],
                                   @"orderBy":self.orderBy,
                                   @"goodsType":self.type
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

- (void)creatTypeData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *muDic = @{
                                   @"parent.id":self.type
                                   }.mutableCopy;
    [APIManager GetShopTypeWithParameters:muDic success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSArray *dicArray = data[@"list"];
        self.typeDataSource = [ShopTypeModel mj_objectArrayWithKeyValuesArray:dicArray];
        self.goodClassVC.dataSource = self.typeDataSource;
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


- (IBAction)salesType:(UIButton *)sender {
    btnTyp += 1;

    NSInteger type = btnTyp % 3;
    switch (type) {
        case 0:
        {
            self.salesTypeImage.image = [UIImage imageNamed:@"icon_rank_n"];
            self.orderBy = @"";
            [self.myCollectionView.mj_header  beginRefreshing];

        }
            break;
        case 1:
        {
            self.salesTypeImage.image = [UIImage imageNamed:@"icon_rank_s"];
            self.orderBy = @"sale asc";
            [self.myCollectionView.mj_header  beginRefreshing];


        }
            break;
        case 2:
        {
            self.salesTypeImage.image = [UIImage imageNamed:@"icon_rank_s1"];
            self.orderBy = @"sale desc";
            [self.myCollectionView.mj_header  beginRefreshing];

        }
            break;
        default:
            break;
    }
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
    self.goodClassVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsClassVC"];
    [self addChildViewController:self.goodClassVC];
    
    WS(weakSelf);
    [self.goodClassVC setMyBlock:^(ShopTypeModel *model){
        weakSelf.goodsType = model.id;
        
        [weakSelf.myCollectionView.mj_header  beginRefreshing];
    }];
    
}

- (void)searchAction:(UIButton *)sender {
    MyLog(@"搜索");
    
    SearchViewController *seachVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"SearchVC"];
    seachVC.type = NO;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
}

- (IBAction)chooseClass:(UIButton *)sender {
    if ([self.mybgView.subviews containsObject:self.goodClassVC.view]) {
        [UIView animateWithDuration:0.36 animations:^{
            self.goodClassVC.view.frame = CGRectMake(TheW, 0, TheW, TheH);
            self.goodClassVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.goodClassVC.view removeFromSuperview];
        }];
    } else {
        self.goodClassVC.view.alpha = 0;
        self.goodClassVC.view.frame = CGRectMake(TheW, 0, TheW, TheH);
        [UIView animateWithDuration:0.36 animations:^{
            self.goodClassVC.view.frame = CGRectMake(0, 0,TheW, TheH);
            self.goodClassVC.view.alpha = 1;
        }];
        [self.mybgView addSubview:self.goodClassVC.view];
    }
}


- (void)creatCollectionView {
    // Initialization code
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCell"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake((TheW - 30) / 2.0,  (TheW - 30) * 0.9 / 2.0);
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 10;
    //设置最小行间距
    layOut.minimumLineSpacing = 10;
    layOut.sectionInset = UIEdgeInsetsMake(10,10, 10, 10);
    self.myCollectionView.collectionViewLayout = layOut;
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-GoodsListViewController-释放");
    
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
