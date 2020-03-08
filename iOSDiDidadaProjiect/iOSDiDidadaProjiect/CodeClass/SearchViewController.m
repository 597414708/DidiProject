//
//  SearchViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/26.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "SearchViewController.h"
#import "HomePageCollectionCell.h"
#import "StoreHomeViewController.h"
#import "ShopModel.h"

#import "GoodsModel.h"
#import "GoodsDetailViewController.h"
@interface SearchViewController () <UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation SearchViewController
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setBarButtonItem];
    [self creatListView];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
}

- (void)creatShopData:(NSString *)name {
    NSMutableDictionary *muDic = @{@"x": [userDef objectForKey:Longitude],
                                   @"y": [userDef objectForKey:Latitude],
                                   @"name":name
                                   }.mutableCopy;
    [APIManager GetNearShopWithParameters:muDic success:^(id data) {
        [self.dataSource removeAllObjects];
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            ShopModel *model = [[ShopModel alloc] init];
            model = [ShopModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        [self.myCollectionView reloadData];
    } failure:^(NSError *error) {
        [self.myCollectionView reloadData];
    }];
}

- (void)creatGoodsData:(NSString *)name  {
    NSMutableDictionary *muDic = @{
                                   @"shopId":@"1",
                                   @"name":name
                                   }.mutableCopy;
    [APIManager GetShopGoodslistWithParameters:muDic success:^(id data) {
        [self.dataSource removeAllObjects];
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            GoodsModel *model = [[GoodsModel alloc] init];
            model = [GoodsModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
       
        
        [self.myCollectionView reloadData];
    } failure:^(NSError *error) {
        [self.myCollectionView reloadData];

    }];
}



- (void)setBarButtonItem
{
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
  
    //默认提示文字
    searchBar.placeholder = @"搜索内容";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = kCOLOR_HEX(0x595959);
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:14];
    //输入框背景颜色
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    //拿到取消按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //设置按钮上的文字
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    //设置按钮上文字的颜色
    [cancleBtn setTitleColor:APPColor forState:UIControlStateNormal];
    [titleView addSubview:searchBar];
    titleView.layer.cornerRadius = 15;
    titleView.layer.masksToBounds = YES;
    
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];

    if (self.type) {
        [self creatShopData:searchBar.text];
    } else {
        [self creatGoodsData:searchBar.text];
    }
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *inputStr = searchText;
//    [self.results removeAllObjects];
//    for (ElderModel *model in self.dataArray) {
//        if ([model.name.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
//            [self.results addObject:model];
//        }
//    }
//    [self.tableView reloadData];
    
    
    
   
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type) {
        HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCell" forIndexPath:indexPath];
        ShopModel *model = self.dataSource[indexPath.row];
        [cell showDataWith:model];
        return cell;
    } else {
        HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCell" forIndexPath:indexPath];
        GoodsModel *model = self.dataSource[indexPath.row];
        [cell showDataMall:model];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type) {
        StoreHomeViewController *storeHomeVC = [[StoreHomeViewController alloc] init];
        ShopModel *model = self.dataSource[indexPath.row];
        storeHomeVC.model = model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeHomeVC animated:YES];
    } else {
        GoodsDetailViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
        VC.model = self.dataSource[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

- (void)dealloc
{
    MyLog(@"-SearchViewController-释放");
    
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
