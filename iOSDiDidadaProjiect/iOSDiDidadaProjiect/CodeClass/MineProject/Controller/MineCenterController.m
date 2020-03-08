//
//  MineCenterController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MineCenterController.h"
#import "HeadCollectionCell.h"

#import "MineListTableViewCell.h"

#import "ListModel.h"

#import "BillsViewController.h"
#import "CallcenterViewController.h"
#import "MyOrderViewController.h"

#import "PersonalDataController.h"

#import "PolicyListViewController.h"
#import "AdressListViewController.h"

#import "CarportViewController.h"

#import "LoginViewController.h"

#import "BusinessmanVController.h"

#import "UserModel.h"

#import "ZYInputAlertFieldView.h"
#import "OrderListViewController.h"
#import "HelpViewController.h"

#import "MyWebViewController.h"
#import "UserHomeModel.h"
#import "QrcodeView.h"
#import "AgentCenterVC.h"

#import "BaoJiajiluSearchVC.h"

@interface MineCenterController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource >

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (nonatomic, strong) NSMutableArray *listDataSource;
@property (weak, nonatomic) IBOutlet UILabel *shenqiLab;
@property (weak, nonatomic) IBOutlet UIImageView *qrImage;
@property (weak, nonatomic) IBOutlet UILabel *baodanNum;
@property (weak, nonatomic) IBOutlet UILabel *carNum;
@property (nonatomic, strong) UserHomeModel *model;

@property (nonatomic, strong) UserModel *userModel;

@property (nonatomic , assign) BOOL isFlag;

@end

@implementation MineCenterController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)listDataSource {
    if (!_listDataSource) {
        self.listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}


- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
}


- (void)refresh {
    [APIManager GetUserhomeWithParameters:nil success:^(id data) {
        self.model = [UserHomeModel mj_objectWithKeyValues:data];
        if ([self.model.info1 isEqualToString:@"1"]) {
            self.qrImage.hidden = NO;
            self.shenqiLab.hidden = YES;
        } else if ([self.model.info1 isEqualToString:@"0"]) {
            self.qrImage.hidden = YES;
            self.shenqiLab.hidden = NO;
        }
        self.carNum.text = self.model.carNum;
        self.baodanNum.text = self.model.indentNum;
        [self.myTableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];

    }];
    
    [APIManager GetUserFreshWithParameters:nil success:^(id data) {
        NSDictionary *dic = data;
        self.userModel = [[UserModel alloc] init];
        self.userModel = [UserModel mj_objectWithKeyValues:dic];
        
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.userModel.userHead] placeholderImage:placeHoder];
        self.nameLab.text = self.userModel.nickName;
    } failure:^(NSError *error) {
        
    }];
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
    UIImage *rightImageS = [[UIImage imageNamed:@"icon_outid"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImageS style:UIBarButtonItemStylePlain target:self action:@selector(exitAction)];

    [self creatUI];
    [self creatCollectionView];
    
    [self creatData];
    [self creatListData];
    [self refreshData];
}

- (void)exitAction {
    UIAlertController *alertContol = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        MyLog(@"点击事件");
    }];
    [alertContol addAction:okAction];
    [alertContol addAction:cancelAction];
    [self presentViewController:alertContol animated:YES completion:nil];
 }

- (void)refreshData {
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        [weakSelf refresh];
    }];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
}

//代理商
- (IBAction)dilishang:(UIButton *)sender {
    if ([self.model.info1 isEqualToString:@"0"]) {
        ZYInputAlertFieldView *alertView = [ZYInputAlertFieldView alertView];
        alertView.inputTextView.placeholder = @"请输入联系人姓名";
        alertView.secondField.placeholder = @"请输入手机号";
        alertView.secondField.keyboardType = UIKeyboardTypeNumberPad;
        [alertView confirmBtnClickBlock:^(NSString *inputString, NSString *second) {
            if (inputString.length == 0) {
                [MBProgressHUD showMessage:@"请输入联系人姓名" toView:nil];
                return;
            }
            if (second.length == 0) {
                [MBProgressHUD showMessage:@"请输入联系方式" toView:nil];
                return;
            }
            NSMutableDictionary *dic = @{@"name":inputString,
                                         @"info3":second
                                         }.mutableCopy;
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager ToAgentWithParameters:dic success:^(id data) {
                [MBProgressHUD showMessage:@"提交成功" toView:nil];
            } failure:^(NSError *error) {
            }];
        }];
        [alertView show];
    } else if ([self.model.info1 isEqualToString:@"1"]) {
        AgentCenterVC *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AgentCenterVC"];
        billVC.url = self.model.shareUrl;
        billVC.mobile = self.userModel.mobile;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:billVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
    }
}

//我的保单
- (IBAction)baodanAction:(UIButton *)sender {
    PolicyListViewController *policyVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"PolicyListVC"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:policyVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

//车库
- (IBAction)chekuAction:(UIButton *)sender {
    CarportViewController *carportVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarportVC"];
    self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:carportVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)creatData {
    
    ListModel *model1 = [[ListModel alloc] init];
    model1.className = @"商品订单";
    model1.bgImage = @"icon_goodso";
    
    ListModel *model2 = [[ListModel alloc] init];
    model2.className = @"分期账单";
    model2.bgImage = @"icon_cycle-billing";
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = @"我的预约";
    model3.bgImage = @"icon_order";
    
    ListModel *model4 = [[ListModel alloc] init];
    model4.className = @"个人资料";
    model4.bgImage = @"icon_pinformation";
    
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model4];
}

- (void)creatListData {
    
    ListModel *model2 = [[ListModel alloc] init];
    model2.className = @"成为商家";
    model2.bgImage = @"icon_becs";
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = @"地址管理";
    model3.bgImage = @"icon_address";
    
    ListModel *model4 = [[ListModel alloc] init];
    model4.className = @"客服中心";
    model4.bgImage = @"icon_nservice";
    
    ListModel *model5 = [[ListModel alloc] init];
    model5.className = @"帮助中心";
    model5.bgImage = @"icon_heipme";
    
    ListModel *model6 = [[ListModel alloc] init];
    model6.className = @"报价记录";
    model6.bgImage = @"icon_discen";

    [self.listDataSource addObject:model6];
    [self.listDataSource addObject:model2];
    [self.listDataSource addObject:model3];
    [self.listDataSource addObject:model4];
    [self.listDataSource addObject:model5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = TheW * 151 / 375 +  TheW / 6 + TheW / 4 + 7;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];
}



- (void)creatCollectionView {
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

- (void)creatUI {
    self.headImage.layer.cornerRadius = 35;
    self.headImage.layer.masksToBounds = YES;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"我的";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 45;
    [self.myTableView registerNib:[UINib nibWithNibName:@"MineListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineListCell"];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HeadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellS" forIndexPath:indexPath];
    ListModel *model = self.dataSource[indexPath.row];
    [cell showListData:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UINavigationController *nav = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"OrderListNV"];
        OrderListViewController *orderVC = (OrderListViewController *)nav.topViewController;
        orderVC.tag = YES;
        [self.tabBarController presentViewController:nav animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        BillsViewController *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"billVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 2) {
        MyOrderViewController *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyOrderVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 3) {
        PersonalDataController *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"PersonalDataVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ListModel *model = self.listDataSource[indexPath.row];
    [cell showListData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        BaoJiajiluSearchVC *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaoJiajiluSearchVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myWebVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 1) {
        BusinessmanVController *businessmanVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BusinessmanVC"];
        self.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:businessmanVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 2) {
        AdressListViewController *adressListVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AdressListVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adressListVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 3) {
        CallcenterViewController *callVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CallcenterVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:callVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.row == 4) {
        HelpViewController *personalDataVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"HelpVC"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalDataVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}


- (void)dealloc {
    MyLog(@"-MineCenterController-释放");
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
