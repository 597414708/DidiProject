//
//  OrderDetialController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OrderDetialController.h"

#import "OrderCenterGoodsModel.h"

#import "SelectAddressCell.h"

#import "OrderGoodsCell.h"

#import "OrderdataCell.h"

#import "AddressOrderCell.h"

#import "InforListTableViewCell.h"

#import "LogisticsInforController.h"

#import "PostModel.h"

@interface OrderDetialController ()<UITableViewDelegate, UITableViewDataSource> {
    NSString *postStr;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) PostModel *postmodel;
@property (weak, nonatomic) IBOutlet UILabel *allPrice;

@end

@implementation OrderDetialController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showData];
    [self creatUI];
    
}

- (void)showData {
    if (!self.model.expressNo) {
        postStr = @"暂未发货";
        return;
    }
    NSDictionary *dic = @{@"num":self.model.expressNo};
    [APIManager ExpressInfoWithParameters:dic.mutableCopy success:^(id data) {
       self.postmodel = [PostModel mj_objectWithKeyValues:data];
        
        if (self.postmodel.data.count > 0) {
            PostListModel *listmodel = self.postmodel.data.firstObject;
            
            postStr = listmodel.context;
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)refreshData {
    NSDictionary *dic = @{@"id":self.model.id};
    
    [APIManager GetIndentDetailWithParameters:dic.mutableCopy success:^(id data) {
        NSDictionary *dic = data;
        self.model = [[OrderCenterModel alloc] init];
        self.model = [OrderCenterModel mj_objectWithKeyValues:dic];
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)creatUI {
    
    self.allPrice.text = [NSString stringWithFormat:@"总计 ¥:%@", self.model.payMoney];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"订单详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    [self.myTableView registerNib:[UINib nibWithNibName:@"SelectAddressCell" bundle:nil] forCellReuseIdentifier:@"SelectAddressCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderGoodsCell" bundle:nil] forCellReuseIdentifier:@"OrderGoodsCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderdataCell" bundle:nil] forCellReuseIdentifier:@"OrderdataCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"AddressOrderCell" bundle:nil] forCellReuseIdentifier:@"AddressOrderCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"InforListTableViewCell" bundle:nil] forCellReuseIdentifier:@"InforListTableViewCell"];
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.model.indentList.count;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (indexPath.section == 0) {
        SelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectAddressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showPost:postStr];
        return cell;
    } else if (indexPath.section == 1) {
        OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderCenterGoodsModel *model = self.model.indentList[indexPath.row];
        [cell showDataCenter:model];
        return cell;
    } else if (indexPath.section == 2) {
        OrderdataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderdataCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.goodsPriceLab.text = [NSString stringWithFormat:@"¥ %@", self.model.totalMoney];
        cell.allPriceLab.text = [NSString stringWithFormat:@"¥ %@", self.model.payMoney];
        return cell;
    } else if(indexPath.section == 3) {
        AddressOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressOrderCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showData:self.model];
        return cell;
    } else  {
        InforListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InforListTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *classname = @"";
        NSString *content = @"";
        switch (indexPath.row) {
            case 0:
            {
                classname = @"发票信息";
                if ([self.model.needInvoice isEqualToString:@"1"]) {
                    content = [NSString stringWithFormat:@"%@", self.model.invoiceName];
                } else {
                    content = @"不开发票";
                }
               
            }
                break;
            case 1:
            {
                classname = @"订单编号";
                content = self.model.orderNo;
            }
                break;
            case 2:
            {
                classname = @"下单时间";
                content = self.model.payTime;
            }
                break;
                
            default:
                break;
        }
        cell.classNameLab.text = classname;
        cell.contentLab.text = content;
        
        return cell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 56;
    } else if (indexPath.section == 1) {
        return  101;
    } else if (indexPath.section == 2) {
        return 101;
    } else if (indexPath.section == 3) {
        return 65;
    } else {
        return 41;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && postStr) {
        if (!self.model.expressNo) {
            return;
        }
        LogisticsInforController *logistVC  = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"LogisticsInforVC"];
        self.hidesBottomBarWhenPushed = YES;
        logistVC.model = self.model;
        logistVC.dataSource = self.postmodel.data;
        [self.navigationController pushViewController:logistVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-OrderDetialController-释放");
    
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
