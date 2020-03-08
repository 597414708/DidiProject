//
//  AllBillListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AllBillListViewController.h"
#import "BilldetailTableViewCell.h"
#import "AllBillModel.h"

@interface AllBillListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@end

@implementation AllBillListViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self refresh];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"全部账单";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"BilldetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"BillCell"];
    
}

- (void)refresh {
    WS(weakSelf);
    self.page = 1;
    
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
    
    NSMutableDictionary *muDic = @{
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager FenqiBillListWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            AllBillModel *model = [[AllBillModel alloc] init];
            model = [AllBillModel mj_objectWithKeyValues:dic];
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
    BilldetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AllBillModel *model = self.dataSource[indexPath.row];
    [cell showData:model];

    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-AllBillListViewController-释放");
    
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
