//
//  CarportViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarportViewController.h"
#import "CarportListTableViewCell.h"
#import "CarDatainforViewController.h"
#import "CarInforModel.h"

#import "ViolationListViewController.h"
#import "WeizhangModel.h"
#import "ViolationCheckViewController.h"

#import "VehicleInfoViewController.h"

@interface CarportViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *weiZhangArray;

@end

@implementation CarportViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)weiZhangArray {
    if (!_weiZhangArray) {
        self.weiZhangArray = [NSMutableArray array];
    }
    return _weiZhangArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (void)creatData {
    NSMutableDictionary *dic = @{@"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager GetGetCarListWithParameters:dic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data;
        for (NSDictionary *dic in dicArray) {
            CarInforModel *model = [[CarInforModel alloc] init];
            model = [CarInforModel mj_objectWithKeyValues:dic];
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

- (void)creatUI {
 
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"车库管理";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds=CGRectMake(0, 0, 40, 30);
    [rightButton setTitle:@"添加" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [rightButton setTitleColor:APPColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, self.navigationItem.rightBarButtonItem];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 151;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"CarportListTableViewCell" bundle:nil] forCellReuseIdentifier:@"CarportListCell"];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
}

- (void)rightButtonClick {
    CarDatainforViewController *carDatainforVC =[kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarDatainforVC"];
    carDatainforVC.tag = 0;
    WS(weakSelf);
    [carDatainforVC setMyBlock:^{
        [weakSelf refresh];
    }];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carDatainforVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarportListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarportListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CarInforModel *model = self.dataSource[indexPath.row];
    WS(weakSelf);
    [cell setDeletelnBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        CarInforModel *indexModel = weakSelf.dataSource[path.row];
        NSDictionary *mudic = @{@"id":indexModel.id};
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager DoCarDeleteWithParameters:mudic.mutableCopy success:^(id data) {
            NSString *str = data;
            [MBProgressHUD showMessage:str toView:nil];
            [weakSelf.dataSource removeObjectAtIndex:path.row];
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];

        } failure:^(NSError *error) {
            
        }];
    }];
    
    
    [cell setChaXunBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        CarInforModel *indexModel = weakSelf.dataSource[path.row];
        ViolationCheckViewController *ViolationCheckVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"ViolationCheckVC"];
        ViolationCheckVC.model = indexModel;
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:ViolationCheckVC animated:YES];
    }];
    
    
    [cell setCheXianBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        CarInforModel *indexModel = weakSelf.dataSource[path.row];
        VehicleInfoViewController *VehicleInfoVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"VehicleInfoVC"];
        VehicleInfoVC.model = indexModel;
        HelpPramodel.postmodel.renewalCarType = @"0";
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VehicleInfoVC animated:YES];
    }];

    [cell showData:model];
    return cell;
}


- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    CarportListTableViewCell *cell = (CarportListTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CarInforModel *model = self.dataSource[indexPath.row];
    CarDatainforViewController *carDatainforVC =[kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarDatainforVC"];
    carDatainforVC.tag = 1;
    carDatainforVC.model = model;
    WS(weakSelf);
    [carDatainforVC setMyBlock:^{
        [weakSelf refresh];
    }];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carDatainforVC animated:YES];
    
    
}

- (void)dealloc {
    MyLog(@"-CarportViewController-释放");
    
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
