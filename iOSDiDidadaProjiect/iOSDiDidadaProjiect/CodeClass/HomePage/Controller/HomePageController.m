//
//  HomePageController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "HomePageController.h"

#import "ClassHeadCollectionCell.h"

#import "HomePageHeadView.h"

#import "PushViewController.h"

#import "JFLocation.h"

#import "JFAreaDataManager.h"

#import "JFCityViewController.h"

#import "VehicleInfoViewController.h"


#import "MallViewController.h"

#import "LoginViewController.h"

#import "ViolationCheckViewController.h"

#import "StoreHomeViewController.h"

#import "JFCityViewController.h"
#import "CallcenterViewController.h"

#import "CheXingViewController.h"

#import "MyWebViewController.h"

#import "ShopModel.h"
#import "BanaModel.h"
#import "HomeTypeModel.h"

#import "ListModel.h"
#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "AreaView.h"

#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomePageController () <UICollectionViewDelegate, UICollectionViewDataSource, JFLocationDelegate, JFCityViewControllerDelegate, SDCycleScrollViewDelegate> {
    NSMutableArray *firstArray;
    NSMutableArray *secondArray;
    NSMutableArray *arra;
    UIBarButtonItem *rightItem;
}

@property (weak, nonatomic) IBOutlet UICollectionView *myTypeCollectionView;

/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager *manager;

@property (nonatomic, strong) HomePageHeadView *headerView;

@property (nonatomic , assign) BOOL isFlag;

@property (nonatomic , assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *photoArray;
@property (weak, nonatomic) IBOutlet UIView *cityView;
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;

@property (weak, nonatomic) IBOutlet UIView *tfBgView;
@property (weak, nonatomic) IBOutlet UIButton *baojiaBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *firstCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *secondCollectionView;

@property (nonatomic, strong) NSMutableArray *firstDataSource;

@property (nonatomic, strong) NSMutableArray *secondDataSource;
@property (weak, nonatomic) IBOutlet UITableView *bgTableView;

@property (nonatomic, assign) float listHight;
@property (weak, nonatomic) IBOutlet UITextField *carNumtf;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
//专门负责地理位置编码 (正向和反向)
@property (nonatomic ,strong)CLGeocoder *geocoder;

@end

@implementation HomePageController


- (CLGeocoder *)geocoder {
    if (_geocoder == nil) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareInstance];
        [_manager areaSqliteDBData];
    }
    return _manager;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)firstDataSource {
    if (!_firstDataSource) {
        self.firstDataSource = [NSMutableArray array];
    }
    return _firstDataSource;
}

- (NSMutableArray *)secondDataSource {
    if (!_secondDataSource) {
        self.secondDataSource = [NSMutableArray array];
    }
    return _secondDataSource;
}


- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, TheW, (TheW * 145/ 375 )) delegate:self placeholderImage:nil];
        //        _topPhotoBoworr.boworrWidth = Screen_Width;
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        //        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 60;
        //self.view.userInteractionEnabled
        //_topPhotoBoworr.autoScroll = NO;
        _topPhotoBoworr.currentPageDotImage = [UIImage imageNamed:@"pic_bani_s"];
        _topPhotoBoworr.pageDotImage = [UIImage imageNamed:@"pic_bani_n"];
    }
    return _topPhotoBoworr;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![userDef objectForKey:Longitude]) {
        [userDef setObject:@"" forKey:Longitude];
        [userDef setObject:@"" forKey:Latitude];
    }
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    [self creatUI];
    [self creatListView];
    [self creatFirstListView];
    [self creatVisitorsRefresh];
    [self getBananArray];
    [self creatTypeData];
    [self.cityView addSubview:self.topPhotoBoworr];
  
    
}

- (void)creatTypeData {
    
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
    model4.className = @"智慧旅游";
    model4.bgImage = @"icon_stopmoney";
    
    [self.dataSource addObject:model1];
    
    [self.dataSource addObject:model2];
    
    [self.dataSource addObject:model3];
    
    [self.dataSource addObject:model4];
}

- (void)getBananArray {
    [APIManager BannerListWithParameters:nil success:^(id data) {
        NSArray *array = data;
        self.photoArray = [BanaModel mj_objectArrayWithKeyValuesArray:array];
        firstArray = [NSMutableArray array];
        secondArray = [NSMutableArray array];
        for (BanaModel *model in self.photoArray) {
            if ([model.type isEqualToString:@"1"]) {
                [firstArray addObject:model];
            }
        }
        for (BanaModel *model in self.photoArray) {
            if ([model.type isEqualToString:@"2"]) {
                [secondArray addObject:model];
            }
        }
        arra = [NSMutableArray array];
        for (BanaModel *model in firstArray) {
            [arra addObject:model.pic];
        }
        if (arra.count >= 1) {
            self.topPhotoBoworr.imageURLStringsGroup = arra;
        }
    } failure:^(NSError *error) {
        
    }];
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
    self.bgTableView.mj_header = header;
}

- (void)creatData {
    NSMutableDictionary *muDic = @{@"type":@"0"}.mutableCopy;
    [APIManager AdListWithParameters:muDic success:^(id data) {
        NSArray *dicArray = data;
        if (self.isFlag) {
            [self.firstDataSource removeAllObjects];
        }
        self.firstDataSource = [HomeTypeModel mj_objectArrayWithKeyValuesArray:dicArray];
        [self.firstCollectionView reloadData];
        NSMutableDictionary *muDic1 = @{@"type":@"1"}.mutableCopy;
        [APIManager AdListWithParameters:muDic1 success:^(id data) {
            NSArray *dicArray = data;
            if (self.isFlag) {
                [self.secondDataSource removeAllObjects];
            }
            self.secondDataSource = [HomeTypeModel mj_objectArrayWithKeyValuesArray:dicArray];
            [self.bgTableView.mj_header endRefreshing];
            [self.secondCollectionView reloadData];
            NSInteger count =  self.secondDataSource.count % 2 > 0 ?self.secondDataSource.count / 2 + 1 : self.secondDataSource.count / 2 ;
            self.listHight = count * ((TheW - 30) / 2.0) / 225 * 93 + 10 * (count  - 1 );
            [self updateHeadFram];
        } failure:^(NSError *error) {
            [self.bgTableView.mj_header endRefreshing];
        }];
    } failure:^(NSError *error) {
        [self.bgTableView.mj_header endRefreshing];
    }];
    
    [APIManager BaojiaCountWithParameters:nil success:^(id data) {
        NSString *count = [NSString stringWithFormat:@"%@", data];
        self.countLab.text = [NSString stringWithFormat:@"%@", count];
    } failure:^(NSError *error) {
        
    }];
}

- (void)creatUI {
    
    self.tfBgView.layer.cornerRadius = 6.0;
    self.tfBgView.layer.masksToBounds = YES;
    
    self.baojiaBtn.layer.cornerRadius = 6.0;
    self.baojiaBtn.layer.masksToBounds = YES;
    self.carNumtf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    UIImage *rightImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:rightImage];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:rightImage];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"icon_logo"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 100, 40);
    [leftBtn setTitle:@" 嘀嘀在线" forState:UIControlStateNormal];
    [leftBtn setTitleColor:APPColor forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationController.navigationBar.tintColor = APPColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(5, 15, 0, -15)];
    
    self.navigationItem.leftBarButtonItems = @[self.navigationItem.leftBarButtonItem];
    
    NSString *cityS = [userDef objectForKey:Dcity];
    if (cityS.length == 0) {
        cityS = @"全城";
    }
    
    rightItem = [[UIBarButtonItem alloc] initWithTitle:cityS style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    
    [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                    [UIFont systemFontOfSize:14], NSFontAttributeName,
                                                                    APPblackColor, NSForegroundColorAttributeName,
                                                                    nil]
                                                          forState:UIControlStateNormal];
    
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_location"] style:UIBarButtonItemStylePlain target:self action:nil];
    [imageItem setImageInsets:UIEdgeInsetsMake(2, 15, 0, -15)];
    
    UIBarButtonItem *kefuItem = [self creatKefuItem];
    self.navigationItem.rightBarButtonItems = @[kefuItem, rightItem, imageItem];
}

- (UIBarButtonItem *)creatKefuItem {
    NSTextAttachment *attachMent2 = [[NSTextAttachment alloc] init];
    //设置图片
    attachMent2.image = [UIImage imageNamed:@"icon_kefu"];
    //设置图片的大小
    CGFloat height2 = 18;
    attachMent2.bounds = CGRectMake(0, -5, height2, height2);
    NSAttributedString *attstring2 = [NSAttributedString attributedStringWithAttachment:attachMent2];
    NSString *str2 = @" 客服";
    NSMutableAttributedString *strM2 = [[NSMutableAttributedString alloc] initWithAttributedString:attstring2];
    [strM2 appendAttributedString:[[NSAttributedString alloc] initWithString: str2]];
    UILabel *button2 = [[UILabel alloc] init];
    button2.frame = CGRectMake(0, 0, 40, 40);
    button2.attributedText = strM2;
    button2.textColor = APPblackColor;
    button2.userInteractionEnabled = YES;
    button2.font = [UIFont systemFontOfSize:14];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kefuAction)];
    [button2 addGestureRecognizer:tap2];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button2];
    return item;
}

- (void)kefuAction {
    NSString *sessionId = [userDef objectForKey: USERID];
    if (sessionId.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        return;
    }
    CallcenterViewController *callVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CallcenterVC"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:callVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)rightAction:(UIButton *)sender {
    JFCityViewController *jc = [[JFCityViewController alloc] init];
    jc.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:jc];
    [self presentViewController:navigationController animated:YES completion:nil];
}


- (void)leftAction:(UIButton *)sender {
    
    
}

- (IBAction)choseAreaAction:(UIButton *)sender {
    [self.phoneNum resignFirstResponder];
    [self.carNumtf resignFirstResponder];
    AreaView *view = [AreaView shareAreaViewWith:self.areaLab.text];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    [view setAreaBlock:^(NSString *str){
        self.areaLab.text = str;
    }];
}

- (IBAction)finishAction:(UIButton *)sender {
    NSString *carNum = [NSString stringWithFormat:@"%@%@", self.areaLab.text, self.carNumtf.text];
    if (![HelpManager checkCarNumber:carNum]) {
        [MBProgressHUD showMessage:@"请输入正确车牌号" toView:nil];
        return;
    }
    
    NSString *sessionId = [userDef objectForKey: USERID];
    if (sessionId.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        return;
    }
    VehicleInfoViewController *VehicleInfoVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"VehicleInfoVC"];
    VehicleInfoVC.arrea = self.areaLab.text;
    VehicleInfoVC.numCode = self.carNumtf.text;
    HelpPramodel.postmodel.renewalCarType = @"0";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VehicleInfoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//定位成功
- (void)currentLocation:(CLPlacemark *)locationDictionary {
    [HelpManager shareHelpManager].starPlacemark = locationDictionary;
    NSDictionary * locationDictionaryS = [locationDictionary addressDictionary];
    NSString *city = [locationDictionaryS valueForKey:@"City"];
    NSString *cityS = [locationDictionaryS valueForKey:@"SubLocality"];
    
    float latitude = locationDictionary.location.coordinate.latitude;
    float longitude = locationDictionary.location.coordinate.longitude;
    
    [userDef setObject:[NSString stringWithFormat:@"%f", latitude] forKey:Latitude];
    [userDef setObject:[NSString stringWithFormat:@"%f", longitude] forKey:Longitude];
    
    [userDef setObject:[NSString stringWithFormat:@"%@", cityS] forKey:Dcity];
    
    [rightItem setTitle:cityS];
    
    
    if (![rightItem.title isEqualToString:cityS]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"您定位到%@，确定切换城市吗？",city] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [rightItem setTitle:[NSString stringWithFormat:@" %@", cityS]];
            
            [userDef setObject:city forKey:@"locationCity"];
            [userDef setObject:city forKey:@"currentCity"];
            [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
                [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - JFCityViewControllerDelegate

- (void)cityName:(NSString *)name {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self geoAddress:name];

}
- (void)geoAddress:(NSString *)address {
    //这是正向编码的方法
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [rightItem setTitle:[NSString stringWithFormat:@" %@", address]];

        //CLPlacemark地表对象
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocationCoordinate2D coordinate = placemark.location.coordinate;
//        NSLog(@"经度:%f, 纬度:%f", coordinate.longitude, coordinate.latitude);
//        NSLog(@"精度:%f, 纬度:%f, 海拔:%f, 速度:%f, 航向:%f", coordinate.longitude, coordinate.latitude, placemark.location.altitude, placemark.location.speed, placemark.location.course);
        [userDef setObject:[NSString stringWithFormat:@"%f", coordinate.latitude] forKey:Latitude];
        [userDef setObject:[NSString stringWithFormat:@"%f", coordinate.longitude] forKey:Longitude];
        
        [KCURRENTCITYINFODEFAULTS setObject:address forKey:@"cityNumber"];

        
        
    }];
}

#pragma mark --- JFLocationDelegate
//定位中...
- (void)locating {
    NSLog(@"定位中...");
}

/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}

/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}


- (void)creatListView {
    //创建layout
    self.myTypeCollectionView.delegate = self;
    self.myTypeCollectionView.dataSource = self;
    [self.myTypeCollectionView registerNib:[UINib nibWithNibName:@"ClassHeadCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellS"];
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(TheW / 4, 120);
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 0;
    //设置最小行间距
    layOut.minimumLineSpacing = 0;
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.myTypeCollectionView.collectionViewLayout = layOut;
}


- (void)creatFirstListView {
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layOut.itemSize = CGSizeMake(TheW / 8, 87);
    layOut.minimumInteritemSpacing = 0;
    layOut.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    
    self.firstCollectionView.collectionViewLayout = layOut;
    self.firstCollectionView.delegate = self;
    self.firstCollectionView.dataSource = self;
    [self.firstCollectionView registerNib:[UINib nibWithNibName:@"FirstCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FirstCollectionViewCell"];
    self.firstCollectionView.backgroundColor = [UIColor whiteColor];
    
    JYEqualCellSpaceFlowLayout *myLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:10];
    myLayout.minimumLineSpacing = 10;
    //    myLayout.itemSize = CGSizeMake(43 / 2.0, 43/2.0);
    myLayout.itemSize = CGSizeMake((TheW - 30) / 2.0, ((TheW - 30) / 2.0) / 225 * 93);
    //    self.weight.constant = 3 * 9 + TheW * CellWeight / 375.0 * 10;
    //    self.height.constant = TheW * CellWeight / 375.0 * 2 + 5;
    self.secondCollectionView.collectionViewLayout = myLayout;
    self.secondCollectionView.delegate = self;
    self.secondCollectionView.dataSource = self;
    [self.secondCollectionView registerNib:[UINib nibWithNibName:@"SecondCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SecondCollectionViewCell"];
    self.secondCollectionView.backgroundColor = [UIColor clearColor];
}


- (void)updateHeadFram {
    [self.bgTableView beginUpdates];
    CGRect headerFrame = self.bgTableView.tableHeaderView.frame;
    headerFrame.size.height = TheW * 143.0 / 375 +  4 + 125 + 44 + 232 + 44 + 87 + 5 + 10 + self.listHight + 10;
    //修改tableHeaderView的frame
    self.bgTableView.tableHeaderView.frame = headerFrame;
    [self.bgTableView endUpdates];
    
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.myTypeCollectionView) {
        return self.dataSource.count;
    } else if (collectionView == self.firstCollectionView) {
        return self.firstDataSource.count;
    } else {
        return self.secondDataSource.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.myTypeCollectionView) {
        ClassHeadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellS" forIndexPath:indexPath];
        ListModel *model = self.dataSource[indexPath.row];
        [cell showListData:model];
        return cell;
    } else if (collectionView == self.firstCollectionView) {
        FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstCollectionViewCell" forIndexPath:indexPath];
        HomeTypeModel *model = self.firstDataSource[indexPath.row];
        [cell showData:model];
        return cell;
    } else {
        SecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SecondCollectionViewCell" forIndexPath:indexPath];
        HomeTypeModel *model = self.secondDataSource[indexPath.row];
        
        [cell showData:model];
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.myTypeCollectionView == collectionView) {
        if (indexPath.row == 0) {
            MallViewController *mfVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MallVC"];
            mfVC.secondArray = secondArray.mutableCopy;
            [self presentViewController:mfVC animated:YES completion:nil];
        }
        
        if (indexPath.row == 1) {
            NSString *sessionId = [userDef objectForKey: USERID];
            if (sessionId.length == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
                return;
            }
            CheXingViewController *VehicleInfoVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CheXingVC"];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VehicleInfoVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        
        if (indexPath.row == 2) {
            NSString *sessionId = [userDef objectForKey: USERID];
            if (sessionId.length == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
                return;
            }
            ViolationCheckViewController *ViolationCheckVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"ViolationCheckVC"];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ViolationCheckVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
        if (indexPath.row == 3) {
            [MBProgressHUD showMessage:@"暂未开放" toView:nil];
        }
    }
    
    if (self.firstCollectionView == collectionView) {
        
    }
    
    if (self.secondCollectionView == collectionView) {
        HomeTypeModel *model = self.secondDataSource[indexPath.row];

        NSString *str = [NSString stringWithFormat:@"%@", model.jump];
        if (![str isEqualToString:@"0"]) {
            MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
            myWebVC.webUrl = model.link;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myWebVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
    
    
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    BanaModel *model = firstArray[index];
    if (model.link.length > 0) {
        MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
        myWebVC.webUrl = model.link;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myWebVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}
- (void)dealloc
{
    MyLog(@"-HomePageController-释放");
    
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
