//
//  OrderListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/27.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderListViewController.h"

#import "OrderListTableViewCell.h"
#import "CommentViewController.h"
#import "LogisticsInforController.h"

#import "OrderCenterModel.h"

#import "GoodsModel.h"

#import "OrderCenterGoodsModel.h"

#import "GoodsOrderViewController.h"

#import "OrderDetialController.h"

#import "ZYInputAlertFieldView.h"

#import "CgoodListViewController.h"

@interface OrderListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation OrderListViewController

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

    UIImage *rightImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.navigationController.navigationBar setBackIndicatorImage:rightImage];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:rightImage];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = APPColor;
    
    if (self.tag) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    }
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"订单中心";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 163;
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderListTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderListTableViewCell"];
}


- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    [APIManager GetIndentListWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        
        
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            OrderCenterModel *model = [[OrderCenterModel alloc] init];
            model = [OrderCenterModel mj_objectWithKeyValues:dic];
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
    OrderListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    OrderCenterModel *model =  self.dataSource[indexPath.row];
    [cell showData:model];
    WS(weakSelf);
    [cell setDelateBlock:^(UIButton *sender) {
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        OrderCenterModel *model =  weakSelf.dataSource[path.row];
        [weakSelf getPostServer1:sender.tag - 100 With:model];
    }];
    
    [cell setCommentBlock:^(UIButton *sender){
        NSIndexPath *path = [weakSelf getIndexWith:sender];
        OrderCenterModel *model =  weakSelf.dataSource[path.row];
        [weakSelf getPostServer2:sender.tag - 100 With:model];
    }];
    
    return cell;
}

- (void)getPostServer1:(NSInteger)tag With:(OrderCenterModel *)model {
    NSMutableDictionary *dic = @{@"id": model.id}.mutableCopy;
    
    if (tag == 3) {
        ZYInputAlertFieldView *alertView = [ZYInputAlertFieldView alertView];
        alertView.inputTextView.hidden = YES;
        alertView.tfHeight.constant = 80;
        alertView.secondField.placeholder = @"请填写退货原因";
        [alertView confirmBtnClickBlock:^(NSString *inputString, NSString *second) {
            if (second.length == 0) {
                [MBProgressHUD showMessage:@"请填写退货原因" toView:self.view];
                return ;
            }
            [dic setObject:second forKey:@"returnRemark"];
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager GetIndentReturnGoodslWithParameters:dic success:^(id data) {
                [self.myTableView reloadData];
            } failure:^(NSError *error) {
                
            }];
            
        }];
        [alertView show];
    }
    
    if (tag == 0) {
        //支付
        NSMutableArray *goodsArray = [NSMutableArray array];
        for (OrderCenterGoodsModel *modelS in model.indentList) {
            GoodsModel *modelD  = [[GoodsModel alloc] init];
            modelD.num = modelS.number;
            modelD.name = modelS.goodsName;
            modelD.goodsImg = modelS.goodsImg;
            modelD.id = modelS.goodsId;
            modelD.price = [NSString stringWithFormat:@"%.2f", ([modelS.goodsMoney floatValue] * (modelS.number))];
            [goodsArray addObject:modelD];
        }
        GoodsOrderViewController *goodsOrderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsOrderVC"];
        self.hidesBottomBarWhenPushed = YES;
        goodsOrderVC.dataSource = goodsArray;
        goodsOrderVC.orderNumStr = model.orderNo;
        [self.navigationController pushViewController:goodsOrderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)getPostServer2:(NSInteger)tag With:(OrderCenterModel *)model {
    NSMutableDictionary *dic = @{@"id": model.id}.mutableCopy;
    
    if (tag == -1 || tag == 52 || tag == 62 || tag == 10) {
        //删除
        UIAlertController *alertContol = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager GetIndentdeleteWithParameters:dic success:^(id data) {
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
    
    if (tag == 1) {
        //退款
        ZYInputAlertFieldView *alertView = [ZYInputAlertFieldView alertView];
        alertView.inputTextView.hidden = YES;
        alertView.tfHeight.constant = 80;
        alertView.secondField.placeholder = @"请填写退款原因";
        [alertView confirmBtnClickBlock:^(NSString *inputString, NSString *second) {
            if (second.length == 0) {
                [MBProgressHUD showMessage:@"请填写退款原因" toView:self.view];
                return ;
            }
            [dic setObject:second forKey:@"refundRemark"];
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager GetIndentReturnMoneylWithParameters:dic success:^(id data) {
                [self refresh];
            } failure:^(NSError *error) {
                
            }];
            
        }];
        [alertView show];
    }
    
    /*
     */
    
    if (tag == 2) {
        //确认收货
        UIAlertController *alertContol = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认收货" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager IndentReceiveWithParameters:dic success:^(id data) {
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
    
    if (tag == 4) {
        ZYInputAlertFieldView *alertView = [ZYInputAlertFieldView alertView];
        alertView.inputTextView.hidden = YES;
        alertView.tfHeight.constant = 80;
        alertView.secondField.placeholder = @"请填写退货原因";
        [alertView confirmBtnClickBlock:^(NSString *inputString, NSString *second) {
            if (second.length == 0) {
                [MBProgressHUD showMessage:@"请填写退货原因" toView:self.view];
                return ;
            }
            [dic setObject:second forKey:@"returnRemark"];
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager GetIndentReturnGoodslWithParameters:dic success:^(id data) {
                [self refresh];
            } failure:^(NSError *error) {
                
            }];
            
        }];
        [alertView show];
    }
    
    if (tag == 0) {
        //取消
        UIAlertController *alertContol = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要取消订单?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showHUDAddedTo:nil animated:YES];
            [APIManager GetIndentCancelWithParameters:dic success:^(id data) {
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
    
    if (tag == 3) {
        //评价
        
        if (model.indentList.count == 1) {
            CommentViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CommentVC"];
            VC.model = model.indentList.firstObject;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        } else {
            CgoodListViewController *cgoodvc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CgoodVC"];
            cgoodvc.dataSource = model.indentList;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cgoodvc animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
       
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderCenterModel *model =  self.dataSource[indexPath.row];
    
    if ([model.indentStatus isEqualToString:@"0"]) {
        NSMutableArray *goodsArray = [NSMutableArray array];
        for (OrderCenterGoodsModel *modelS in model.indentList) {
            GoodsModel *modelD  = [[GoodsModel alloc] init];
            modelD.num = modelS.number;
            modelD.name = modelS.goodsName;
            modelD.goodsImg = modelS.goodsImg;
            modelD.id = modelS.goodsId;
            modelD.price = [NSString stringWithFormat:@"%.2f", ([modelS.goodsMoney floatValue] * (modelS.number))];
            [goodsArray addObject:modelD];
        }
        GoodsOrderViewController *goodsOrderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsOrderVC"];
        self.hidesBottomBarWhenPushed = YES;
        goodsOrderVC.dataSource = goodsArray;
        goodsOrderVC.orderNumStr = model.orderNo;
        [self.navigationController pushViewController:goodsOrderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    } else {
        OrderDetialController *orderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"OrderDetialVC"];
        orderVC.model = model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    OrderListTableViewCell *cell = (OrderListTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-OrderListViewController-释放");
    
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
