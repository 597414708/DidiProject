//
//  GoodsOrderViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsOrderViewController.h"

#import "SelectAddressCell.h"

#import "OrderGoodsCell.h"

#import "OrderdataCell.h"

#import "OrderSelectTableViewCell.h"

#import "PayTableViewCell.h"

#import "GoodsModel.h"

#import "AdressListViewController.h"

#import "AddressDataModel.h"

#import "ZYInputAlertFieldView.h"

#import "PayTypeModel.h"

#import "AppDelegate.h"

#import "FapiaoView.h"

@interface GoodsOrderViewController () <UITableViewDelegate, UITableViewDataSource> {
    float allPrice;
    float postPrice;
    AddressDataModel *defaultModel;
    NSDictionary *invoiceDic;
    
    NSString *paytype;
    
    ///发票
    NSString *invoiceStr;
    
    //1个人    0不用    2单位
    NSString *dd;
}


@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *payTypeArray;


@end

@implementation GoodsOrderViewController

- (NSMutableArray *)payTypeArray {
    if (!_payTypeArray) {
        self.payTypeArray = [NSMutableArray array];
    }
    return _payTypeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    paytype = @"0";
    
    [self creatData];
    [self creatUI];
    [self getAddress];
    
    [kAppDelegate setWXpayBlock:^(BOOL staute) {
        if (staute) {
            [MBProgressHUD showMessage:@"支付成功" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [kAppDelegate setAlipayBlock:^(BOOL staute) {
        if (staute) {
            [MBProgressHUD showMessage:@"支付成功" toView:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}

- (void)creatData {
    PayTypeModel *model = [[PayTypeModel alloc] init];
    model.headImage = @"zicon_weixin";
    model.content = @"微信支付";
    model.select = YES;
    model.type = @"0";
    
    
    PayTypeModel *model1 = [[PayTypeModel alloc] init];
    model1.headImage = @"icon_zhifub";
    model1.content = @"支付宝";
    model1.select = NO;
    model1.type = @"1";

    [self.payTypeArray addObject:model];
    [self.payTypeArray addObject:model1];

    
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"商品详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"SelectAddressCell" bundle:nil] forCellReuseIdentifier:@"SelectAddressCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderGoodsCell" bundle:nil] forCellReuseIdentifier:@"OrderGoodsCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderdataCell" bundle:nil] forCellReuseIdentifier:@"OrderdataCell"];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderSelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"OrderSelectTableViewCell"];

    [self.myTableView registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:nil] forCellReuseIdentifier:@"PayTableViewCell"];
    invoiceStr = @"不开发票";
    invoiceDic = @{@"invoiceName" : @"",
                   @"invoiceContent" : @""
                   };

    for (GoodsModel *model in self.dataSource) {
        allPrice += [model.price floatValue];
    }
}


//支付
- (IBAction)payAction:(UIButton *)sender {
    
    if (!(defaultModel.id)) {
        [MBProgressHUD showMessage:@"请选择地址" toView:nil];
        return;
    }
    [self byGoods];
}

- (void) byGoods {
    NSMutableArray *goosArray = [NSMutableArray array];
    for (GoodsModel *model in self.dataSource) {
        NSDictionary *dic = @{@"id":model.id,
                              @"num":@"1"};
        [goosArray addObject:dic];
    }
    if ([invoiceStr isEqualToString:@"不开发票"]) {
        dd = @"0";
    }
    
    if (self.orderNumStr) {
        [HelpManager payWithOrder:self.orderNumStr WithType:paytype WithWeb:nil];
        return;
    }
    
    NSMutableDictionary *modelDic = @{@"addressId": defaultModel.id,
                                      @"needInvoice":dd,
                                      @"goodsList" :goosArray,
                                    @"invoiceName" :invoiceDic[@"invoiceName"],
                                      @"invoiceContent" : invoiceDic[@"invoiceContent"]
                                      }.mutableCopy;
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    
    [APIManager GetAddByGoodsWithParameters:modelDic success:^(id data) {
        self.orderNumStr = data;
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [HelpManager payWithOrder:self.orderNumStr WithType:paytype WithWeb:nil];
    } failure:^(NSError *error) {
        
    }];
}



- (void)getAddress {
    [APIManager AddressdefaultWithParameters:nil success:^(id data) {
       defaultModel = [AddressDataModel mj_objectWithKeyValues:data];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return 40;
    }
    return 0;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 4) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = [NSString stringWithFormat:@"   %@", @"支付方式"];
        lab.textColor = Color(51, 51, 51);
        lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
        return lab;
    } else {
        UIView *e = [UIView new];
        return e;
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.dataSource.count;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 1;
    } else {
        return self.payTypeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SelectAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectAddressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (defaultModel.id) {
            [cell showData:defaultModel];
        }
        return cell;
    } else if (indexPath.section == 1) {
        OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        GoodsModel *model = self.dataSource[indexPath.row];
        [cell showData:model];
        return cell;
    } else if (indexPath.section == 2) {
        OrderdataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderdataCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.goodsPriceLab.text = [NSString stringWithFormat:@"¥ %.2f", allPrice];
        cell.allPriceLab.text = [NSString stringWithFormat:@"¥ %.2f", allPrice];
        return cell;
    } else if (indexPath.section == 3) {
        OrderSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderSelectTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell showData:invoiceStr];
        return cell;
    } else {
        PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PayTypeModel *model = self.payTypeArray[indexPath.row];
        [cell showData:model];
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 45;
    } else if (indexPath.section == 1) {
        return  101;
    } else if (indexPath.section == 2) {
        return 101;
    } else if (indexPath.section == 3) {
        return 41;
    } else {
        return 61;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //选择收货地址
        AdressListViewController *adressListVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AdressListVC"];
        [adressListVC setMyBlock:^(AddressDataModel *model) {
            defaultModel = model;
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:adressListVC animated:YES];
    }
    
    if (indexPath.section == 3) {

        FapiaoView *view = [FapiaoView shareFapiaoView];
        [view setMyBlock:^(NSMutableArray *sender) {
            
            if ([sender.firstObject isEqualToString:@"-1"]) {
                
                
                invoiceDic = @{@"invoiceName" : @"",
                               @"invoiceContent" : @""
                               };
                dd = @"0";
                invoiceStr = [NSString stringWithFormat:@"不开发票"];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            } else {
                if ([sender[0] isEqualToString:@"0"]) {
                    dd = @"1";
                } else {
                    dd = @"2";
                }
                
                invoiceDic = @{@"invoiceName" : sender[1],
                               @"invoiceContent" : sender[2]
                               };
                invoiceStr = [NSString stringWithFormat:@"%@ 发票", sender[1]];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }];
        
        [self.view addSubview:view];
    }
    
    
    if (indexPath.section == 4) {
        //选择支付方式
        PayTypeModel *model = self.payTypeArray[indexPath.row];
        paytype = model.type;
        for (PayTypeModel *model in self.payTypeArray) {
            model.select = NO;
        }
        model.select = YES;
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:4];
        [tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-GoodsOrderViewController-释放");
    
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
