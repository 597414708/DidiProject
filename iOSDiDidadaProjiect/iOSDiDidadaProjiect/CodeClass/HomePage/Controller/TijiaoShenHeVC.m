//
//  TijiaoShenHeVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/15.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "TijiaoShenHeVC.h"
#import "MyWebViewController.h"
#import "PayTypeModel.h"
#import "PayListTableViewCell.h"

@interface TijiaoShenHeVC ()<UITableViewDelegate, UITableViewDataSource> {
    float allPrice;
}

@property (weak, nonatomic) IBOutlet UITableView *myTabView;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@property (nonatomic, strong) NSMutableArray *payArray;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@end

@implementation TijiaoShenHeVC

- (NSMutableArray *)payArray {
    if (!_payArray) {
        self.payArray = [NSMutableArray array];
    }
    return _payArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData];
}

- (void)creatData {
    PayTypeModel *model1 = [[PayTypeModel alloc] init];
    float sum =  [self.senderModel.bizTotal floatValue] + [self.senderModel.taxTotal floatValue] + [self.senderModel.forceTotal floatValue];
    
    model1.content =[NSString stringWithFormat:@"不分期 ¥%.2f", sum] ;
    model1.type = @"1";
    model1.select = YES;
    
    allPrice = sum;
    PayTypeModel *model2 = [[PayTypeModel alloc] init];
    model2.content = [NSString stringWithFormat:@"%.2fX12期", allPrice / 12];
    model2.type = @"12";
    model2.select = NO;
    
    [self.payArray addObject:model1];
    [self.payArray addObject:model2];

}

- (void)creatUI {
    [self.myTabView registerNib:[UINib nibWithNibName:@"PayListTableViewCell" bundle:nil] forCellReuseIdentifier:@"PayListTableViewCell"];
    
    self.myTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTabView.delegate = self;
    self.myTabView.dataSource = self;
    self.myTabView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTabView.rowHeight = UITableViewAutomaticDimension;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.senderModel.logo] placeholderImage:placeHoder];
    self.nameLab.text = self.senderModel.name;
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
}

- (IBAction)agreeAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}


- (IBAction)baoxianAction:(UIButton *)sender {
    
    MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
    myWebVC.type = @"5";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWebVC animated:YES];
}

- (IBAction)gaozhiAction:(UIButton *)sender {
    MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
    myWebVC.type = @"6";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWebVC animated:YES];
}

- (IBAction)pingTaiAction:(UIButton *)sender {
    MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
    myWebVC.type = @"7";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWebVC animated:YES];
}


- (IBAction)finishAction:(UIButton *)sender {
    if (!self.agreeBtn.selected) {
        [MBProgressHUD showMessage:@"请同意服务协议" toView:nil];
        return;
    }
    
    PayTypeModel *model = [[PayTypeModel alloc] init];
    for (PayTypeModel *modelS in self.payArray) {
        if (modelS.select) {
            model = modelS;
        }
    }
    
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    NSDictionary *pram = @{
                           @"carOwnersName":HelpPramodel.postmodel.carOwnersName,
                           @"idCard":HelpPramodel.postmodel.idCard,
                           @"ownerIdCardType":HelpPramodel.postmodel.ownerIdCardType,
                           
                           @"insuredName":HelpPramodel.postmodel.insuredName,
                           @"insuredIdCard":HelpPramodel.postmodel.insuredIdCard,
                           @"insuredIdType":HelpPramodel.postmodel.insuredIdType,
                           @"insuredMobile":HelpPramodel.postmodel.insuredMobile,
                           
                           @"holderName":HelpPramodel.postmodel.holderName,
                           @"holderIdCard":HelpPramodel.postmodel.holderIdCard,
                           @"holderIdType":HelpPramodel.postmodel.holderIdType,
                           @"holderMobile":HelpPramodel.postmodel.holderMobile,
                           
                           @"info4":self.senderModel.indentId,
                           @"totalMoney":[NSString stringWithFormat:@"1"],
                           @"totalNum":model.type};
    [APIManager FenqiAddWithParameters:pram.mutableCopy success:^(id data) {
        [MBProgressHUD showMessage:@"提交成功" toView:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {

    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.payArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayListTableViewCell" forIndexPath:indexPath];
    PayTypeModel *model = self.payArray[indexPath.row];
    [cell showData:model];
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = [NSString stringWithFormat:@"   %@", @"分期方式"];
    lab.textColor = Color(51, 51, 51);
    lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
    return lab;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PayTypeModel *model = self.payArray[indexPath.row];
    if ([model.type isEqualToString:@"1"]) {
        [MBProgressHUD showMessage:@"联系客服，享受更多优惠" toView:nil];
    }
    for (PayTypeModel *models in self.payArray) {
        models.select = NO;
    }
    model.select = YES;
    NSIndexSet *SET = [NSIndexSet indexSetWithIndex:0];
    [self.myTabView reloadSections:SET withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-TijiaoShenHeVC-释放");
    
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
