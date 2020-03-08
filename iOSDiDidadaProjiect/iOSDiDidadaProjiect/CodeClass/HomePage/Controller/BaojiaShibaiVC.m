//
//  BaojiaShibaiVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaShibaiVC.h"
#import "BaojiaShibaiCell.h"
#import "ListModel.h"
#import "BaojiaModel.h"
#import "InsuredPlanViewController.h"
#import "UserInfo.h"

@interface BaojiaShibaiVC ()<UITableViewDelegate, UITableViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UILabel *licenseNoLab;
@property (weak, nonatomic) IBOutlet UILabel *modleNameLab;

@property (weak, nonatomic) IBOutlet UILabel *licenseOwnerLab;
@property (weak, nonatomic) IBOutlet UILabel *engineNoLab;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLab;
@property (weak, nonatomic) IBOutlet UILabel *carVinLab;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImageLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSDictionary *inforDic;

@end

@implementation BaojiaShibaiVC

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
    [self DetailcreatData];
    
}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"报价详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.topBgView.layer.cornerRadius = 4;
    self.topBgView.layer.masksToBounds = YES;
    
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self.myTableView registerNib:[UINib nibWithNibName:@"BaojiaShibaiCell" bundle:nil] forCellReuseIdentifier:@"BaojiaShibaiCell"];
 
}

- (void)creatData {
    ListModel *model0 = [[ListModel alloc] init];
    model0.className = @"交强险";
    model0.content = @"";
    model0.state = @"一 一";

    ListModel *model1 = [[ListModel alloc] init];
    model1.className = @"车船险";
    model1.content = @"";
    model1.state = @"一 一";

    ListModel *model2 = [[ListModel alloc] init];
    model2.className = @"商业险";
    model2.content = @"";
    model2.state = @"一 一";
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = @"报价状态";
    model3.content = @"报价失败";
    model3.state = @"";
    
    ListModel *model4 = [[ListModel alloc] init];
    model4.className = @"报价内容";
    model4.content = self.senderModel.quoteResult;
    model4.state = @"";
    
    ListModel *model5 = [[ListModel alloc] init];
    model5.className = @"核保状态";
    model5.content = self.senderModel.submitResult;
    model5.state = @"";
    [self.dataSource addObject:model0];
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
    [self.dataSource addObject:model4];
    [self.dataSource addObject:model5];
}


- (void)DetailcreatData {
    NSMutableDictionary *dicMu = [NSMutableDictionary dictionary];
    dicMu = @{@"info4":self.indentId
              }.mutableCopy;
    self.senderModel = [[InsurerListmodel alloc] init];    
    
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager BaodanDetailWithParameters:dicMu success:^(id data) {
        NSDictionary *dic = data[@"returnParam"][@"item"];
        BaojiaModel *model = [[BaojiaModel alloc] init];
        model = [BaojiaModel mj_objectWithKeyValues:dic];
        self.senderModel.bizTotal = model.bizTotal;
        self.senderModel.taxTotal = model.taxTotal;
        self.senderModel.forceTotal = model.forceTotal;
        self.senderModel.quoteResult = model.quoteResult;
        self.senderModel.quoteStatus = model.quoteStatus;
        self.senderModel.submitResult = model.submitResult;
        self.senderModel.statusMessage = data[@"returnParam"][@"statusMessage"];
        self.senderModel.indentId = data [@"indentId"];
        self.senderModel.priceList = model.priceList;
        NSDictionary *userdic = data[@"returnParam"][@"userInfo"];
        
        self.inforModel = [UserInfo mj_objectWithKeyValues:userdic];
        self.inforModel.licenseOwner = @"";
        self.inforModel.registerDate = data[@"postParam"][@"registerDate"];
        self.inforModel.modleName = data[@"postParam"][@"moldName"];
        self.inforModel.businessStartDate = data[@"postParam"][@"bizTimeStamp"];
        self.inforModel.forceStartDate = data[@"postParam"][@"forceTimeStamp"];
        NSString *renewalCarType = [NSString stringWithFormat:@"%@", data[@"postParam"][@"renewalCarType"]];
        if ([renewalCarType isEqualToString:@"1"]) {
            self.senderModel.quoteResult = self.senderModel.statusMessage;
        }
        self.inforModel.licenseNo = data[@"postParam"][@"licenseNo"];
        NSString *logo = data[@"info"][@"sourceLogo"];
        NSString *name = data[@"info"][@"sourceName"];
        NSString *inforStr =  data[@"info"][@"postparam"];
        self.inforDic = [HelpManager dictionaryWithJsonString:inforStr];
        self.senderModel.logo = logo;
        self.senderModel.name = name;
        [self updateUI:self.inforModel];
        [self creatData];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)finishiAction:(UIButton *)sender {

    BOOL tag = YES;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[InsuredPlanViewController class]]) {
            tag = NO;
            InsuredPlanViewController *senderVc =(InsuredPlanViewController *)vc;
            [self.navigationController popToViewController:senderVc animated:YES];
        }
    }
    
    if (tag) {
        if (self.inforDic) {
            HelpPramodel.postmodel = nil;
            InsuredPlanViewController *InsuredPlanVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"InsuredPlanVC"];
            
            UserInfo *senderInfor = [[UserInfo alloc] init];
            senderInfor.licenseNo = [NSString stringWithFormat:@"%@",self.inforDic[@"LicenseNo"]];
            senderInfor.modleName = [NSString stringWithFormat:@"%@",self.inforDic[@"MoldName"]];
            senderInfor.carVin = [NSString stringWithFormat:@"%@",self.inforDic[@"CarVin"]];
            senderInfor.engineNo = [NSString stringWithFormat:@"%@",self.inforDic[@"EngineNo"]];
            senderInfor.registerDate = [NSString stringWithFormat:@"%@",self.inforDic[@"RegisterDate"]];
            senderInfor.licenseOwner = @"";
            HelpPramodel.postmodel.renewalCarType = [NSString stringWithFormat:@"%@",self.inforDic[@"RenewalCarType"]];
            HelpPramodel.postmodel.cityCode = [NSString stringWithFormat:@"%@",self.inforDic[@"CityCode"]];

            senderInfor.forceExpireDate = [HelpManager getDate: self.inforDic[@"ForceTimeStamp"] With:@"YYYY-MM-dd"] ;
            senderInfor.businessExpireDate = [HelpManager getDate: self.inforDic[@"BizTimeStamp"] With:@"YYYY-MM-dd"];
            
            senderInfor.cityCode = [NSString stringWithFormat:@"%@",self.inforDic[@"CityCode"]];
            InsuredPlanVC.inforModel = senderInfor;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:InsuredPlanVC animated:YES];
        } else {
            
        }
     
    }
}


- (void)updateUI:(UserInfo *)model {
    self.licenseNoLab.text = model.licenseNo;
    self.modleNameLab.text = model.modleName;
    //商业
    self.carVinLab.text = [NSString stringWithFormat:@"交强险起保时间 %@", [HelpManager getDate:self.inforModel.forceStartDate With:@"YYYY-MM-dd"]];
    self.engineNoLab.text = [NSString stringWithFormat:@"商业险起保时间 %@", [HelpManager getDate:self.inforModel.businessStartDate With:@"YYYY-MM-dd"]];
    
    
    self.registerDateLab.text = [NSString stringWithFormat:@"%@", model.registerDate];
    self.licenseOwnerLab.text = [NSString stringWithFormat:@"%@", model.licenseOwner];
    
    [self.headImageLab sd_setImageWithURL:[NSURL URLWithString:self.senderModel.logo] placeholderImage:placeHoder];
    self.nameLab.text = self.senderModel.name;
}

- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = (TheW - 20) / 355.0 * 180 + 20 + 5 + 70 + 5 ;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaojiaShibaiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaShibaiCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ListModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc
{
    MyLog(@"-BaojiaShibaiVC-释放");
//    HelpPramodel.postmodel.renewalCarType  = nil;
//    HelpPramodel.postmodel.cityCode = nil;
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
