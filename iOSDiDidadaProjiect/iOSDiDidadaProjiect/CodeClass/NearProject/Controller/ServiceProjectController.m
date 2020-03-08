//
//  ServiceProjectController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ServiceProjectController.h"
#import "ServiceListCell.h"
#import "StoreHomeListCell.h"
#import "BottomView.h"
#import "GoodsTypeModel.h"

#import "GoodsModel.h"

#import "GoodsFMDBmodel.h"
#import "GoodsOrderViewController.h"
#import "GoodsDetailViewController.h"
@interface ServiceProjectController () <UITableViewDelegate, UITableViewDataSource>
{
    UIView *bottomView;
    int buttonY;
    UIView *lineView;
}

@property (nonatomic, strong) UITableView *leftView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *className;

@property (nonatomic, strong) BottomView *mybottomView;

@property (nonatomic, strong) NSMutableArray *typeDataSource;

@property (nonatomic, strong) NSString *type;

@property (nonatomic , assign) BOOL isFlag;

@property (nonatomic , assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *shopCarArray;



@end

@implementation ServiceProjectController

- (NSMutableArray *)typeDataSource {
    if (!_typeDataSource) {
        self.typeDataSource = [NSMutableArray array];
    }
    return _typeDataSource;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)shopCarArray {
    if (!_shopCarArray) {
        self.shopCarArray = [NSMutableArray array];
    }
    return _shopCarArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(@available(iOS 11.0, *)){self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    self.type = @"";
    [self creatUI];
    [self creatGoodsType];
    [self creatVisitorsRefresh];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        bottomView.frame = CGRectMake(bottomView.frame.origin.x, buttonY+self.tableView.contentOffset.y , bottomView.frame.size.width, bottomView.frame.size.height);
    }
}

- (void)creatUI {

    self.className.text = @"全部";
    self.leftView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 90, TheH)];
    [self.view addSubview:self.leftView];
    self.tableView.tableFooterView = [UIView new];
    lineView = [[UIView alloc] initWithFrame:CGRectMake(90, 0, 5, TheH - 213)];
    lineView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    [self.tableView addSubview:lineView];
    if (iPhoneX) {
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, TheH - 140, TheW, 46)];
    } else {
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, TheH - 110, TheW, 46)];
    }
    
    [self.tableView addSubview:bottomView];
    [self.tableView bringSubviewToFront:bottomView];
    buttonY =(int)bottomView.frame.origin.y;
    self.mybottomView = [BottomView ShareBottomView];
    [bottomView addSubview:self.mybottomView];
    
    WS(weakSelf);
    [self.mybottomView setMyBlock:^{
        if (weakSelf.shopCarArray.count != 0) {
            
            NSString *sessionId = [userDef objectForKey: USERID];
            if (sessionId.length == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
                return;
            }
            GoodsOrderViewController *goodsOrderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsOrderVC"];
            weakSelf.parentViewController.hidesBottomBarWhenPushed = YES;
            
            goodsOrderVC.dataSource = weakSelf.shopCarArray;
            
            [weakSelf.navigationController pushViewController:goodsOrderVC animated:weakSelf];
        }
    }];
    
    self.mybottomView.countLab.text = [NSString stringWithFormat:@"X %ld", self.shopCarArray.count];

    
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreHomeListCell" bundle:nil] forCellReuseIdentifier:@"StoreHomeListCell"];
    self.tableView.rowHeight = 91;
    
    [self.leftView registerNib:[UINib nibWithNibName:@"ServiceListCell" bundle:nil] forCellReuseIdentifier:@"ServiceListCell"];
    self.leftView.rowHeight = 41;
    self.leftView.delegate = self;
    self.leftView.dataSource = self;
    self.leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

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
    self.tableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.tableView.mj_footer = footer;
}



- (void)creatGoodsType {
    NSMutableDictionary *muDic = @{
                                   @"shopId":self.model.id
                                   }.mutableCopy;
    [APIManager GetGoodsTypelistWithParameters:muDic success:^(id data) {
        NSArray *dicArray = data[@"list"];
        self.typeDataSource = [GoodsTypeModel mj_objectArrayWithKeyValuesArray:dicArray];
        
        for (GoodsTypeModel *model in self.typeDataSource) {
            model.tag = @"0";
        }
        [self.leftView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}



- (void)creatData {
    
    NSMutableDictionary *muDic = @{@"goodsType":self.type,
                                   @"shopId":self.model.id,
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager GetGoodsListWithParameters:muDic success:^(id data) {

        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            GoodsModel *model = [[GoodsModel alloc] init];
            model = [GoodsModel mj_objectWithKeyValues:dic];
            if ([[StockCodeFMDB shareStockCodeFMDB] searchMessageModelWith:model.id].count) {
                model.tag = 1;
            }  else {
                model.tag = 0;
            }
            [self.dataSource addObject:model];
        }
        self.page += 1;
        self.isFlag = NO;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftView) {
        return self.typeDataSource.count;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftView) {
        ServiceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GoodsTypeModel *model = self.typeDataSource[indexPath.row];
        [cell showData:model];
        return cell;
    } else {
        StoreHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreHomeListCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cyanColor];
        GoodsModel *model = self.dataSource[indexPath.row];
    
        [cell showData:model];
        WS(weakSelf);
        [cell setMyBlock:^(UIButton *sender) {
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            NSIndexPath *path = [weakSelf getIndexWith:sender];
            GoodsModel *modelS = weakSelf.dataSource[path.row];
            if (!modelS.tag) {
                [weakSelf.shopCarArray addObject:modelS];
                GoodsFMDBmodel *FMDBmodel = [[GoodsFMDBmodel alloc] init];
                FMDBmodel.shopid = weakSelf.model.id;
                FMDBmodel.goodsid = modelS.id;
                [[StockCodeFMDB shareStockCodeFMDB] insertMessageSearchWithContent:FMDBmodel];
                modelS.tag = 1;
                
                [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
                weakSelf.mybottomView.countLab.text = [NSString stringWithFormat:@"X %ld", self.shopCarArray.count];
            } else {
                GoodsModel *modelA = [[GoodsModel alloc] init];
                for (GoodsModel *model in weakSelf.shopCarArray) {
                    if ([model.id isEqualToString:modelS.id]) {
                        modelA = model;
                    }
                }
                
                [weakSelf.shopCarArray removeObject:modelA];
                [[StockCodeFMDB shareStockCodeFMDB] deleteGoodWith:modelS.id];
                modelS.tag = 0;

                [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

                weakSelf.mybottomView.countLab.text = [NSString stringWithFormat:@"X %ld", self.shopCarArray.count];
            }
        }];
        return cell;
    }
   
}



- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    StoreHomeListCell *cell = (StoreHomeListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    return path;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftView) {
        for (GoodsTypeModel *model in self.typeDataSource) {
            model.tag = @"0";
        }
        
        GoodsTypeModel *model = self.typeDataSource[indexPath.row];
        model.tag = @"1";
        self.type = model.id;
        self.className.text = model.typeName;
        [self.tableView.mj_header beginRefreshing];
        
        [tableView reloadData];
    
    } else {
        GoodsModel *model = self.dataSource[indexPath.row];

        GoodsDetailViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
        VC.model = model;
        VC.hide = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-ServiceProjectController-释放");
    
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
