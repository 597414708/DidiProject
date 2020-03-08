//
//  YichuBillsViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "YichuBillsViewController.h"
#import "BillsTableViewCell.h"
#import "GivebackViewController.h"
#import "AllBillListViewController.h"
#import "BillModel.h"
#import "BaojiaDetailVC.h"


@interface YichuBillsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) BillModel *model;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@end

@implementation YichuBillsViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self creatData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self refreshData];

}

- (IBAction)zhangdanAction:(UIButton *)sender {
    AllBillListViewController *allBillVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AllBillVC"];
    [self.navigationController pushViewController:allBillVC animated:YES];
    
}


- (void)creatUI {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 76;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BillsTableViewCell" bundle:nil] forCellReuseIdentifier:@"BillsCell"];
}


- (void)creatData {
    NSMutableDictionary *dic = @{@"next":@"0"}.mutableCopy;
    [APIManager FenqimoneyWithParameters:dic success:^(id data) {
        NSDictionary *dic = data;
        self.model = [BillModel mj_objectWithKeyValues:dic];
        self.dateLab.text = self.model.date;
        self.allPriceLab.text = [NSString stringWithFormat:@"%.2f", [self.model.money floatValue]];
        if ([self.model.money floatValue] == 0) {
            [self.payBtn setTitle:@"已还清" forState:UIControlStateNormal];
        }
        [self.myTableView.mj_header endRefreshing];

        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        [self.myTableView.mj_header endRefreshing];

    }];
    
}

- (void)refreshData {
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        [weakSelf creatData];
    }];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = (TheW * 126 / 375) + 80 + 1 ;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BillListModel *model = self.model.list[indexPath.row];
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BillListModel *model = self.model.list[indexPath.row];

    BaojiaDetailVC *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaDetailVC"];
    billVC.model = model;
    billVC.type = 1;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:billVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)payAction:(UIButton *)sender {
    if ([self.model.money floatValue] == 0) {
        return;
    }
    GivebackViewController *givebackVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GivebackVC"];
    givebackVC.model = self.model;
    givebackVC.dicpram = @{@"orderNo": self.model.orderNo,
                           };
    [self.navigationController pushViewController:givebackVC animated:YES];
}


- (void)dealloc {
    MyLog(@"-YichuBillsViewController-释放");
    
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
