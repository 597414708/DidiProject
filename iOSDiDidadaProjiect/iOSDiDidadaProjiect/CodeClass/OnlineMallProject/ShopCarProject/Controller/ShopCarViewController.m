//
//  ShopCarViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarListCell.h"
#import "ShopCarListGoodsModel.h"
#import "GoodsModel.h"
#import "GoodsOrderViewController.h"

@interface ShopCarViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIButton *allSelectBtn;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@end

@implementation ShopCarViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self refresh];
//    [self creatData];
}

- (IBAction)allSellectAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    for (ShopCarListGoodsModel *model in self.dataSource) {
        model.select = sender.selected;
    }
    [self.myTableView reloadData];
}

- (IBAction)buyAction:(UIButton *)sender {
    NSMutableArray *shopCarArray = [self getGoodsDataSource];
    if (shopCarArray.count != 0) {
        GoodsOrderViewController *goodsOrderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsOrderVC"];
        self.hidesBottomBarWhenPushed = YES;
        goodsOrderVC.dataSource = shopCarArray;
        [self.navigationController pushViewController:goodsOrderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
}

- (NSMutableArray *)getGoodsDataSource {
    NSMutableArray *dataSoo = [NSMutableArray array];
    for (ShopCarListGoodsModel *model in self.dataSource) {
        if (model.select) {
            GoodsModel *modelS = [[GoodsModel alloc] init];
            modelS.num = model.num;
            modelS.name = model.goodsName;
            modelS.goodsImg = model.goodsImg;
            modelS.id = model.goodsId;
            modelS.price = [NSString stringWithFormat:@"%.2f", ([model.price floatValue] * (model.num))];
            [dataSoo addObject:modelS];
        }
    }
    return dataSoo;
}

- (void)creatUI {
    
    
    UIImage *rightImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.navigationController.navigationBar setBackIndicatorImage:rightImage];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:rightImage];
    self.navigationController.navigationBar.tintColor = APPColor;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"购物车";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 91;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ShopCarListCell" bundle:nil] forCellReuseIdentifier:@"ShopCarListCell"];
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
    
    NSMutableDictionary *muDic = @{@"pageSize":@"1000000",
                                   @"shopId":@"1",
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager ShopcartlistWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            ShopCarListGoodsModel *model = [[ShopCarListGoodsModel alloc] init];
            model = [ShopCarListGoodsModel mj_objectWithKeyValues:dic];
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
    ShopCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCarListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopCarListGoodsModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    WS(weakSelf);
    
    [cell setMyBlock:^(UIButton *sender, BOOL addTag) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
      
        ShopCarListGoodsModel *model = weakSelf.dataSource[path.row];
        if (model.num == 1 && !addTag) {
            return ;
        }
        NSString *num = @"1";
        if (!addTag) {
            num = @"-1";
        }
        NSMutableDictionary *dic = @{@"goodsId": model.goodsId,
                                     @"shopId" : @"1",
                                     @"num" :num
                                     }.mutableCopy;
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager ShopcartaddWithParameters:dic success:^(id data) {
            ShopCarListGoodsModel *model = self.dataSource[path.row];
            model.num = model.num  +  [num integerValue];
            [weakSelf.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        } failure:^(NSError *error) {
            
        }];
    }];
    
    [cell setSelectBlock:^(UIButton *sender) {
        
        weakSelf.allSelectBtn.selected = NO;
        NSIndexPath *path = [weakSelf.myTableView indexPathForCell:(ShopCarListCell *)sender.superview.superview.superview];
        ShopCarListGoodsModel *model = weakSelf.dataSource[path.row];
        
        model.select = !sender.selected;
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];

    }];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            ShopCarListGoodsModel *model = self.dataSource[indexPath.row];
            NSMutableDictionary *mudic = @{@"id": model.id}.mutableCopy;
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager ShopcartdelWithParameters:mudic success:^(id data) {
                [MBProgressHUD showMessage:data toView:nil];
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } failure:^(NSError *error) {
                
            }];
        }
 
}

- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    ShopCarListCell *cell = (ShopCarListCell *)sender.superview.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-ShopCarViewController-释放");
    
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
