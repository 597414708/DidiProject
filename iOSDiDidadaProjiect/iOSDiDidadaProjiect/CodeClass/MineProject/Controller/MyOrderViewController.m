//
//  MyOrderViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MyOrderViewController.h"

#import "MyOrderTableViewCell.h"

#import "OrderModel.h"

#import "OrderDateModel.h"

#import "CommentViewController.h"

@interface MyOrderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@end

@implementation MyOrderViewController



- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refresh];
    [self creatUI];
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
    
    NSMutableDictionary *muDic = @{
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager GetGetMyOrderListWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            OrderDateModel *model = [[OrderDateModel alloc] init];
            model = [OrderDateModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
            NSLog(@"%@", model.list);
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
    titleLab.text = @"我的预约";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 100;
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    [self.myTableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrderCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40; 
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    OrderDateModel *model = self.dataSource[section];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.font = [UIFont systemFontOfSize:12];
    lab.text = [NSString stringWithFormat:@"  %@", model.date];
    lab.textColor = Color(51, 51, 51);
    lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
    return lab;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderDateModel *model = self.dataSource[section];
    return model.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderDateModel *model = self.dataSource[indexPath.section];
    OrderModel *modelS = model.list[indexPath.row];
    [cell showDataWith:modelS];
    WS(weakSelf);
    [cell setMyBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        OrderDateModel *model = weakSelf.dataSource[path.section];
        OrderModel *modelS =  model.list[path.row];
        [weakSelf getPostServerWith:modelS];
    }];
    return cell;
}

- (void)getPostServerWith:(OrderModel *)model {
    if (model.status == 0) {
        //取消
        UIAlertController *alertContol = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSDictionary *dic = @{@"id":model.id};
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager CancelOrderWithParameters:dic.mutableCopy success:^(id data) {
                [MBProgressHUD showMessage:@"取消成功" toView:nil];
                [self refresh];
            } failure:^(NSError *error) {

            }];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            MyLog(@"点击事件");
        }];
        [alertContol addAction:okAction];
        [alertContol addAction:cancelAction];
        [self presentViewController:alertContol animated:YES completion:nil];
    }
    
    if (model.status == 1) {
        //评价
        CommentViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CommentVC"];
        VC.orderMd = model;
        WS(weakSelf);
        [VC setMyBlock:^{
            [weakSelf refresh];
        }];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (model.status == 2 || model.status == -1) {
        //删除
        NSDictionary *dic = @{@"id":model.id};
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager DelOrderWithParameters:dic.mutableCopy success:^(id data) {
            [MBProgressHUD showMessage:@"删除成功" toView:nil];
            [self refresh];
        } failure:^(NSError *error) {
            
        }];
    }

}

- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    MyOrderTableViewCell *cell = (MyOrderTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-MyOrderViewController-释放");

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
