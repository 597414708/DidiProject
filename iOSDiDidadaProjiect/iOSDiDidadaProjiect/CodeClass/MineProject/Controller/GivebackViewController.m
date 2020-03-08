//
//  GivebackViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GivebackViewController.h"
#import "PayTableViewCell.h"
#import "PayTypeModel.h"
#import "AppDelegate.h"

@interface GivebackViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSString *paytype;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *payTypeArray;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *linePriceLab;

@end

@implementation GivebackViewController

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
    self.allPriceLab.text = [NSString stringWithFormat:@"%.2f",[self.model.money floatValue]];
    self.linePriceLab.text = [NSString stringWithFormat:@"本月账单共计%.2f元",[self.model.money floatValue]];
    [self creatUI];
    [self creatData];
    
    [kAppDelegate setWXpayBlock:^(BOOL staute) {
        if (staute) {
            [MBProgressHUD showMessage:@"支付成功" toView:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

            });
        }
    }];
    
    [kAppDelegate setAlipayBlock:^(BOOL staute) {
        if (staute) {
            [MBProgressHUD showMessage:@"支付成功" toView:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"还款";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:nil] forCellReuseIdentifier:@"PayCell"];
    
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

- (IBAction)finishAction:(UIButton *)sender {
    [HelpManager fenqipayWithOrder:self.dicpram WithType:paytype WithWeb:nil];

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.payTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PayTypeModel *model = self.payTypeArray[indexPath.row];
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选择支付方式
    PayTypeModel *model = self.payTypeArray[indexPath.row];
    paytype = model.type;
    for (PayTypeModel *model in self.payTypeArray) {
        model.select = NO;
    }
    model.select = YES;
    [tableView reloadData];
    
}

- (void)dealloc {
    MyLog(@"-GivebackViewController-释放");
    
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
