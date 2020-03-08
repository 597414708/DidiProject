//
//  AdressListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "AdressListViewController.h"

#import "AddressTableViewCell.h"

#import "AdaddressViewController.h"

#import "AddressDataModel.h"

@interface AdressListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AdressListViewController

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
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"地址管理";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds=CGRectMake(0, 0, 40, 30);
    [rightButton setTitle:@"新增" forState:UIControlStateNormal];
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
    self.myTableView.rowHeight = 120;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressCell"];
}

- (void)creatData{
    NSMutableDictionary *dic = @{@"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;

//    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager AddresslistWithParameters:dic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            AddressDataModel *model = [[AddressDataModel alloc] init];
            model = [AddressDataModel mj_objectWithKeyValues:dic];
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

- (void)rightButtonClick {
    AdaddressViewController *AdaddressVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AdaddressVC"];
    
    AdaddressVC.tag = 0;
    
    WS(weakSelf);
    [AdaddressVC setMyBlock:^{
        [weakSelf refresh];
    }];
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:AdaddressVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressDataModel *model = self.dataSource[indexPath.row];
   
    
    [cell showData:model];
    WS(weakSelf);
    [cell setEditBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        AdaddressViewController *AdaddressVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AdaddressVC"];
        AdaddressVC.tag = 1;
        AdaddressVC.model = weakSelf.dataSource[path.row];
        [AdaddressVC setMyBlock:^{
            [weakSelf refresh];
        }];
        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:AdaddressVC animated:YES];
    }];
    
    [cell setDeletelnBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        AddressDataModel *model = weakSelf.dataSource[path.row];
        NSMutableDictionary *dic = @{@"id":model.id}.mutableCopy;
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager AddressdelWithParameters:dic success:^(id data) {
            NSString *str = data;
            [MBProgressHUD showMessage:str toView:nil];
            [weakSelf.dataSource removeObjectAtIndex:path.row];
            [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        } failure:^(NSError *error) {
            
        }];
    }];
    
    [cell setSelectBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        AddressDataModel *model = weakSelf.dataSource[path.row];
        model.isdef = labs(model.isdef - 1);
        NSDictionary *DIC = [model mj_keyValues];
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager AddresseditWithParameters:DIC.mutableCopy success:^(id data) {
            [MBProgressHUD showMessage:@"设置成功" toView:nil];
            [weakSelf refresh];
        } failure:^(NSError *error) {
            
        }];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressDataModel *model = self.dataSource[indexPath.row];
    if (self.myBlock) {
        self.myBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    AddressTableViewCell *cell = (AddressTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}



- (void)dealloc {
    MyLog(@"-AdressListViewController-释放");
    
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
