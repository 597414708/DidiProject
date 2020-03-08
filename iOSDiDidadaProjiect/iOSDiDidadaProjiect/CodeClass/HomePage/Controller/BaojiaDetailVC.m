//
//  BaojiaDetailVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/13.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaDetailVC.h"
#import "BaojiaSuccessCell.h"
#import "PriceListModel.h"
#import "InsuredPlanViewController.h"
#import "OwnerInforViewController.h"
#import "BaojiaModel.h"



@interface BaojiaDetailVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UILabel *licenseNoLab;
@property (weak, nonatomic) IBOutlet UILabel *modleNameLab;

@property (weak, nonatomic) IBOutlet UILabel *licenseOwnerLab;
@property (weak, nonatomic) IBOutlet UILabel *engineNoLab;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLab;
@property (weak, nonatomic) IBOutlet UILabel *carVinLab;

@property (weak, nonatomic) IBOutlet UIImageView *headImageLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *cheXingLab;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHight;

@property (nonatomic, strong) NSDictionary *inforDic;

@end

@implementation BaojiaDetailVC

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
    if (self.type) {
     
        if (self.type == 2) {
            
        } else {
            self.bottomView.hidden = YES;
            self.bottomHight.constant = 0;
        }
    
        [self DetailcreatData];
        
    } else {
        //商业
        self.carVinLab.text = [NSString stringWithFormat:@"交强险起保时间 %@", [HelpManager getDate:HelpPramodel.postmodel.forceTimeStamp With:@"YYYY-MM-dd"]];
        self.engineNoLab.text = [NSString stringWithFormat:@"商业险起保时间 %@", [HelpManager getDate:HelpPramodel.postmodel.bizTimeStamp With:@"YYYY-MM-dd"]];
        
        if (HelpPramodel.carDetailType) {
            self.cheXingLab.text = HelpPramodel.carDetailType;
        } else {
            self.cheXingLab.text = HelpPramodel.postmodel.moldName;
        }
        [self updateUI:self.inforModel];
        [self creatData];
    }
 
}

- (void)getTopUI {
    self.carVinLab.text = [NSString stringWithFormat:@"交强险起保时间 %@", [HelpManager getDate:self.inforModel.forceStartDate With:@"YYYY-MM-dd"]];
    self.engineNoLab.text = [NSString stringWithFormat:@"商业险起保时间 %@", [HelpManager getDate:self.inforModel.businessStartDate With:@"YYYY-MM-dd"]];
    
    self.cheXingLab.text = self.inforModel.modleName;

}

- (void)DetailcreatData {
    NSMutableDictionary *dicMu = [NSMutableDictionary dictionary];
    self.senderModel = [[InsurerListmodel alloc] init];

    if (self.model) {
        dicMu = @{@"id":self.model.indentId,
                  }.mutableCopy;
    } else {
        dicMu = @{
                  @"info4":self.baodanmodel.info4
                  }.mutableCopy;
    }
    
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
        self.senderModel.statusMessage = data[@"statusMessage"];
        self.senderModel.indentId = data [@"returnParam"][@"indentId"];
        self.senderModel.priceList = model.priceList;
        NSDictionary *userdic = data[@"returnParam"][@"userInfo"];
        
        self.inforModel = [UserInfo mj_objectWithKeyValues:userdic];
        self.inforModel.licenseOwner = @"";
        
        self.inforModel.registerDate = data[@"postParam"][@"registerDate"];
        self.inforModel.modleName = data[@"postParam"][@"moldName"];
       
        NSString *logo = data[@"info"][@"sourceLogo"];
        NSString *name = data[@"info"][@"sourceName"];
        NSString *licenseNo = data[@"info"][@"licenseNo"];
        NSString *inforStr =  data[@"info"][@"postparam"];
        self.inforDic = [HelpManager dictionaryWithJsonString:inforStr];
        self.inforModel.businessStartDate = data[@"postParam"][@"bizTimeStamp"];
        self.inforModel.forceStartDate = data[@"postParam"][@"forceTimeStamp"];
        self.senderModel.logo = logo;
        self.senderModel.name = name;
        self.inforModel.licenseNo = licenseNo;

        [self updateUI:self.inforModel];
        [self creatData];
        [self getTopUI];
        [self.myTableView reloadData];

    } failure:^(NSError *error) {
        
    }];
}


- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = (TheW - 20) / 355.0 * 180 + 10 + 55 + 80;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

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

    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTableView.rowHeight = UITableViewAutomaticDimension;
    [self.myTableView registerNib:[UINib nibWithNibName:@"BaojiaSuccessCell" bundle:nil] forCellReuseIdentifier:@"BaojiaSuccessCell"];
}

- (void)updateUI:(UserInfo *)model {
    
    [self.headImageLab sd_setImageWithURL:[NSURL URLWithString:self.senderModel.logo] placeholderImage:placeHoder];
    self.nameLab.text = self.senderModel.name;
    
    
    self.licenseNoLab.text = model.licenseNo;
    self.modleNameLab.text = model.modleName;
    self.cheXingLab.text = model.modleName;
    self.registerDateLab.text = [NSString stringWithFormat:@"%@", model.registerDate];
    self.licenseOwnerLab.text = [NSString stringWithFormat:@"%@", model.licenseOwner];
    
    float sum =  [self.senderModel.bizTotal floatValue] + [self.senderModel.taxTotal floatValue] + [self.senderModel.forceTotal floatValue];
    self.priceLab.text = [NSString stringWithFormat:@"¥%.2f", sum];
    
   
}

- (void)creatData {
    NSMutableArray *dataSource1 = [NSMutableArray array];
    PriceListModel *model10 = [[PriceListModel alloc] init];
    model10.name = @"交强险";
    model10.baoFei = self.senderModel.forceTotal;
    PriceListModel *model11 = [[PriceListModel alloc] init];
    model11.name = @"车船税";
    model11.baoFei = self.senderModel.taxTotal;
    [dataSource1 addObject:model10];
    [dataSource1 addObject:model11];
    
    NSMutableArray *dataSource2 = [NSMutableArray array];
    PriceListModel *model20 = [[PriceListModel alloc] init];
    model20.name = @"商业险";
    model20.baoFei = self.senderModel.bizTotal;
    model20.tap = @"0";
    [dataSource2 addObject:model20];
    [dataSource2 addObjectsFromArray:self.senderModel.priceList];
    
    NSMutableArray *dataSource3 = [NSMutableArray array];
    PriceListModel *model30 = [[PriceListModel alloc] init];
    model30.name = @"保险总额";
    float sum =  [self.senderModel.bizTotal floatValue] + [self.senderModel.taxTotal floatValue] + [self.senderModel.forceTotal floatValue];
    model30.baoFei = [NSString stringWithFormat:@"%.2f", sum];

    PriceListModel *model31 = [[PriceListModel alloc] init];
    model31.name = @"核保状态";
    if (self.senderModel.submitResult) {
        model31.baoFei = self.senderModel.submitResult;
    } else {
        model31.baoFei = @"未核保";
    }
    [dataSource3 addObject:model30];
    [dataSource3 addObject:model31];
    
    [self.dataSource addObject:dataSource1];
    [self.dataSource addObject:dataSource2];
    [self.dataSource addObject:dataSource3];
}

- (IBAction)shenqingAction:(UIButton *)sender {
    
    OwnerInforViewController *pushVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"OwnerVC"];
    pushVC.senderModel = self.senderModel;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (IBAction)chongxinAction:(UIButton *)sender {
    
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




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = self.dataSource[section];
    if (section == 1) {
        NSMutableArray *array = self.dataSource[section];
        PriceListModel *model = array[0];
        if ([model.tap isEqualToString:@"0"]) {
            return 1;
        }
    }
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaojiaSuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaSuccessCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableArray *array = self.dataSource[indexPath.section];
    PriceListModel *model = array[indexPath.row];
    [cell showData:model index:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSMutableArray *array = self.dataSource[indexPath.section];
        PriceListModel *model = array[0];
        if ([model.tap isEqualToString:@"0"]) {
            model.tap = @"1";
        } else {
            model.tap = @"0";
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:1];
        [self.myTableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    MyLog(@"-BaojiaDetailVC-释放");
    if (self.inforDic) {
        HelpPramodel.postmodel = nil;
    }
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
