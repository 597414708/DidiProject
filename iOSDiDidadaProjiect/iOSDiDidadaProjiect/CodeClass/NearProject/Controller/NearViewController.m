//
//  NearViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "NearViewController.h"
#import "NearListTableViewCell.h"
#import "StoreHomeViewController.h"
#import "ShopModel.h"
#import <MapKit/MapKit.h>
#import "SearchViewController.h"

@interface NearViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;

/** 地理编码 */
@property(nonatomic ,strong)CLGeocoder *geocoder;


@end

@implementation NearViewController
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}



-(CLGeocoder *)geocoder
{
    if (_geocoder==nil) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
    
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
    [self creatUI];
    [self refresh];
}

- (void)refresh {
    self.page = 1;
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
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.myTableView.mj_footer = footer;
}

- (void)creatUI {
    
//    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
//    titleLab.textColor = APPblackColor;
//    titleLab.text = @"附近";
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
//    self.navigationItem.titleView = titleLab;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
    searchButton.frame = CGRectMake(0, 0, TheW - 60, 30);
    searchButton.backgroundColor = kCOLOR_HEX(0xeeeeee);
    searchButton.layer.cornerRadius = 15;
    searchButton.layer.masksToBounds = YES;
    [searchButton setTitle:@"🔍 搜索店铺" forState:UIControlStateNormal];
    [searchButton setTitleColor:APPGrayColor forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchButton;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 150;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NearListTableViewCell" bundle:nil] forCellReuseIdentifier:@"NearListCell"];
}


- (void)searchAction:(UIButton *)sender {
    SearchViewController *seachVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"SearchVC"];
    seachVC.type = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:seachVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)creatData {
    
    NSMutableDictionary *muDic = @{@"x": [userDef objectForKey:Longitude],
                                   @"y": [userDef objectForKey:Latitude],
                                   @"juli":@"0",
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager GetNearShopWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            ShopModel *model = [[ShopModel alloc] init];
            model = [ShopModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        self.page += 1;
        self.isFlag = NO;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopModel *model = self.dataSource[indexPath.row];
    [cell showDataWith:model];
    
    WS(weakSelf);
    [cell setMyBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        ShopModel *model = weakSelf.dataSource[path.row];
        if (model.info1.length == 0) {
            [MBProgressHUD showMessage:@"无法获取店铺位置" toView:self.view];
            return ;
        }
        
        if ([HelpManager getLocata]) {
            [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];

            CLLocation *loca = [[CLLocation alloc] initWithLatitude:[model.info2 doubleValue] longitude:[model.info1 doubleValue]];
            
            [self.geocoder reverseGeocodeLocation:loca completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

                if (placemarks.count ==0 ||error != nil) {
                    return ;
                }
                CLPlacemark * endPlacemark = [placemarks firstObject];
                
                //4,获得地标后开始导航
                [weakSelf startNavigationWithStartPlacemark:[HelpManager shareHelpManager].starPlacemark endPlacemark:endPlacemark];
            }];

            
        }
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreHomeViewController *storeHomeVC = [[StoreHomeViewController alloc] init];
    ShopModel *model = self.dataSource[indexPath.row];
    storeHomeVC.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:storeHomeVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    NearListTableViewCell *cell = (NearListTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}


/**
 *  利用地标位置开始设置导航
 *
 *  @param startPlacemark 开始位置的地标
 *  @param endPlacemark   结束位置的地标
 */
-(void)startNavigationWithStartPlacemark:(CLPlacemark *)startPlacemark endPlacemark:(CLPlacemark*)endPlacemark
{
    //0,创建起点
    MKPlacemark * startMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:startPlacemark];
    //0,创建终点
    MKPlacemark * endMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:endPlacemark];
    
    //1,设置起点位置
    MKMapItem * startItem = [[MKMapItem alloc]initWithPlacemark:startMKPlacemark];
    //2,设置终点位置
    MKMapItem * endItem = [[MKMapItem alloc]initWithPlacemark:endMKPlacemark];
    //3,起点,终点数组
    NSArray * items = @[startItem ,endItem];
    
    //4,设置地图的附加参数,是个字典
    NSMutableDictionary * dictM = [NSMutableDictionary dictionary];
    //导航模式(驾车,步行)
    dictM[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //地图显示的模式
    dictM[MKLaunchOptionsMapTypeKey] = MKMapTypeStandard;
    
    
    //只要调用MKMapItem的open方法,就可以调用系统自带地图的导航
    //Items:告诉系统地图从哪到哪
    //launchOptions:启动地图APP参数(导航的模式/是否需要先交通状况/地图的模式/..)
    
    [MKMapItem openMapsWithItems:items launchOptions:dictM];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-NearViewController-释放");
    
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
