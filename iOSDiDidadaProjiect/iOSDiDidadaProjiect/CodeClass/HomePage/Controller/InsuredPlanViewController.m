//
//  InsuredPlanViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "InsuredPlanViewController.h"
#import "InsuredListCell.h"
#import "AllinsuredModel.h"

#import "InsuredModel.h"

#import "QuotationListVC.h"

#import "SexAlterView.h"
#import "HZLocation.h"
#import "MyWebViewController.h"

#import "SelectDateViewController.h"
#import "CarTypeViewController.h"


@interface InsuredPlanViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSourceI;

@property (nonatomic, strong) NSMutableArray *dataSourceII;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *topBgView;


@property (weak, nonatomic) IBOutlet UILabel *licenseNoLab;
@property (weak, nonatomic) IBOutlet UILabel *modleNameLab;

@property (weak, nonatomic) IBOutlet UILabel *licenseOwnerLab;
@property (weak, nonatomic) IBOutlet UILabel *engineNoLab;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLab;
@property (weak, nonatomic) IBOutlet UILabel *carVinLab;

@property (weak, nonatomic) IBOutlet UILabel *guohuDate;

@property (weak, nonatomic) IBOutlet UILabel *forceExpireDateLab;

@property (weak, nonatomic) IBOutlet UILabel *businessExpireDateLab;

@property (weak, nonatomic) IBOutlet UILabel *cheXingLab;

@property (strong, nonatomic)SelectDateViewController *dateVC;

@property (weak, nonatomic) IBOutlet UIButton *guohuBtn;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic, assign) BOOL tuozhan;
@property (weak, nonatomic) IBOutlet UILabel *visionLab;

@end

@implementation InsuredPlanViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(SelectDateViewController *)dateVC{
    if (_dateVC==nil) {
        _dateVC = [[SelectDateViewController alloc]init];
        [self addChildViewController:_dateVC];
    }
    return _dateVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
    
    self.guohuBtn.userInteractionEnabled = NO;
    [self creatUI];
    [self creatData];
    [self updateUI:self.inforModel];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    self.visionLab.text = [NSString stringWithFormat:@"%@",app_Version];

}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"选择投保方案";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.topBgView.layer.cornerRadius = 4;
    self.topBgView.layer.masksToBounds = YES;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 41;
    [self.myTableView registerNib:[UINib nibWithNibName:@"InsuredListCell" bundle:nil] forCellReuseIdentifier:@"InsuredCell"];
}


- (void)creatData {
    
    InsuredModel *model1 = [[InsuredModel alloc] init];
    model1.select = @"1";
    model1.insuredAmount =  @"Y";
    model1.coverageName = @"交强险";
    
    InsuredModel *model2 = [[InsuredModel alloc] init];
    model2.select = @"2";
    model2.insuredAmount =  @"Y";
    model2.coverageName = @"车船税";

    AllinsuredModel *modelA = [[AllinsuredModel alloc] init];
    modelA.title = @"交强险+车船险";
    [modelA.dataSource addObject:model1];
    [modelA.dataSource addObject:model2];

    AllinsuredModel *modelB = [[AllinsuredModel alloc] init];
    modelB.title = @"交商业险";
    
    NSString *indicatorsString =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InsurancePlan" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [indicatorsString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dicArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    modelB.dataSource = [InsuredModel mj_objectArrayWithKeyValuesArray:dicArray];
    InsuredModel *modelSS = [[InsuredModel alloc] init];
    
    for (InsuredModel *mm in modelB.dataSource) {
        if ([mm.coverageName isEqualToString:@"交强险"]) {
            modelSS = mm;
            model1.coverageCode = mm.coverageCode;
        }
        if ([mm.insuredAmount containsString:@","]) {
            mm.price = [mm.insuredAmount componentsSeparatedByString:@","].firstObject;
        }
    }
    [modelB.dataSource removeObject:modelSS];
    [self.dataSource addObject:modelA];
    [self.dataSource addObject:modelB];
    [self.myTableView reloadData];
}


- (IBAction)guohuBtn:(UISwitch *)sender {
    if (sender.on) {
        self.guohuBtn.userInteractionEnabled = YES;
    } else {
        self.guohuBtn.userInteractionEnabled = NO;
        self.guohuDate.text = @"(只需过户填写)";
        HelpPramodel.postmodel.transferDate = nil;
    }
}

- (IBAction)baojiaChexing:(UIButton *)sender {
    if (!self.inforModel) {
        return;
    }
    CarTypeViewController *senderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarTypeVC"];
    senderVC.inforModel = self.inforModel;
    WS(weakSelf);
    [senderVC setMyBlock:^(CarTypeModel *sender) {
        HelpPramodel.postmodel.moldName = sender.vehicleName;
        HelpPramodel.postmodel.seatCount = sender.vehicleSeat;
        HelpPramodel.postmodel.autoMoldCode = sender.vehicleNo;
        HelpPramodel.postmodel.exhaustScale = sender.vehicleExhaust;

        weakSelf.cheXingLab.text =  [NSString stringWithFormat:@"%@ %@ %@ %@/%@ %@/%@", sender.vehicleNo, sender.vehicleName, sender.vehicleAlias, sender.vehicleExhaust, sender.vehicleSeat, sender.purchasePrice, sender.vehicleYear];
        HelpPramodel.carDetailType = weakSelf.cheXingLab.text;
    }];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:senderVC animated:YES];
}


//时间选择
- (IBAction)selectDateAction:(UIButton *)sender {
    UILabel *lab;
    if (sender.tag == 101) {
        //强险时间
        lab = self.forceExpireDateLab;
    }
    
    if (sender.tag == 102) {
        //商险时间
        lab = self.businessExpireDateLab;
    }
    
    if (sender.tag == 103) {
        //过户时间
        lab = self.guohuDate;
    }
    
    self.dateVC.beginTime = @"1900-10-10";
    [self.view addSubview:self.dateVC.view];
    [self.dateVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.bottom.equalTo(self.view);
    }];
    [self.dateVC setDateSelectBlock:^(NSString *str){
        lab.text  = str;
        if (sender.tag == 103) {
            HelpPramodel.postmodel.transferDate = str;
        }
    }];
    
}


- (void)updateUI:(UserInfo *)model {
    
    self.licenseNoLab.text = model.licenseNo;
    self.modleNameLab.text = model.modleName;
    self.carVinLab.text = [NSString stringWithFormat:@"车架号 %@", model.carVin];
    self.engineNoLab.text = [NSString stringWithFormat:@"发动机号 %@", model.engineNo];
    self.registerDateLab.text = [NSString stringWithFormat:@"%@", model.registerDate];
    self.licenseOwnerLab.text = [NSString stringWithFormat:@"%@", model.licenseOwner];
    self.cheXingLab.text = @"";
    if ([HelpPramodel.postmodel.renewalCarType isEqualToString:@"1"]) {
        self.cheXingLab.text = model.modleName;
        HelpPramodel.postmodel.moldName = model.modleName;

    }
    self.forceExpireDateLab.text = model.forceExpireDate;
    self.businessExpireDateLab.text = model.businessExpireDate;
    HelpPramodel.postmodel.registerDate = model.registerDate;
    HelpPramodel.postmodel.carVin = model.carVin;
    HelpPramodel.postmodel.engineNo = model.engineNo;
    HelpPramodel.postmodel.licenseNo = model.licenseNo;
}


//确认
- (IBAction)nextAction:(UIButton *)sender {
    if (self.guohuBtn.userInteractionEnabled) {
        if (HelpPramodel.postmodel.transferDate) {
            
        } else {
            [MBProgressHUD showMessage:@"请选择过户日期" toView:nil];
            return;
        }
    }
    
    if ( self.cheXingLab.text.length == 0) {
        [MBProgressHUD showMessage:@"请选择车型" toView:nil];
        return;
    }
    
    AllinsuredModel *allModel0 = self.dataSource[0];
    AllinsuredModel *allModel = self.dataSource[1];
    InsuredModel *modelsetion0 = allModel0.dataSource[0];
    BOOL select1 = NO;
    for (InsuredModel *modellist in allModel.dataSource) {
        if ([modellist.select isEqualToString:@"1"]) {
            select1 = YES;
        }
    }
    BOOL select0 = NO;
    if ([modelsetion0.select isEqualToString:@"1"]) {
        select0 = YES;
    }
    
    if (select0 && select1) {
        HelpPramodel.postmodel.forceTax = @"1";
        HelpPramodel.postmodel.forceTimeStamp = [NSString stringWithFormat:@"%.f", [self getDateWith:self.forceExpireDateLab.text With:@"YYYY-MM-dd"].timeIntervalSince1970];
        HelpPramodel.postmodel.bizTimeStamp = [NSString stringWithFormat:@"%.f", [self getDateWith:self.businessExpireDateLab.text With:@"YYYY-MM-dd"].timeIntervalSince1970];
        if (self.businessExpireDateLab.text.length == 0) {
            [MBProgressHUD showMessage:@"请选择商业险起保日期" toView:nil];
            return;
        }
        if (self.forceExpireDateLab.text.length == 0) {
            [MBProgressHUD showMessage:@"请选择交强险起保时间" toView:nil];
            return;
        }
    }
    
    if (!select0 && select1) {
        HelpPramodel.postmodel.forceTax = @"0";
        HelpPramodel.postmodel.bizTimeStamp = [NSString stringWithFormat:@"%.f", [self getDateWith:self.businessExpireDateLab.text With:@"YYYY-MM-dd"].timeIntervalSince1970];
        if (self.businessExpireDateLab.text.length == 0) {
            [MBProgressHUD showMessage:@"请选择商业险起保日期" toView:nil];
            return;
        }
    }
    
    if (select0 && !select1) {
        HelpPramodel.postmodel.forceTax = @"2";
        HelpPramodel.postmodel.forceTimeStamp = [NSString stringWithFormat:@"%.f", [self getDateWith:self.forceExpireDateLab.text With:@"YYYY-MM-dd"].timeIntervalSince1970];
        if (self.forceExpireDateLab.text.length == 0) {
            [MBProgressHUD showMessage:@"请选择交强险起保时间" toView:nil];
            return;
        }

    }
    
    if (!select0 && !select1) {
        [MBProgressHUD showMessage:@"请选择险种" toView:nil];
        return;
    }
    
    InsuredModel *model0 = allModel.dataSource[0];
    if ([model0.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.sanZhe = [model0.price integerValue];
    } else {
        HelpPramodel.postmodel.sanZhe = 0;

    }
    if (model0.tagflag) {
        HelpPramodel.postmodel.buJiMianSanZhe = 1;
    } else {
        HelpPramodel.postmodel.buJiMianSanZhe = 0;
    }
    
    
    InsuredModel *model1 = allModel.dataSource[1];
    if ([model1.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.siJi = [model1.price integerValue];
    } else {
        HelpPramodel.postmodel.siJi = 0;
    }
    if (model1.tagflag) {
        HelpPramodel.postmodel.buJiMianSiJi = 1;
    } else {
        HelpPramodel.postmodel.buJiMianSiJi = 0;
    }
    
    
    InsuredModel *model2 = allModel.dataSource[2];
    if ([model2.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.chengKe = [model2.price integerValue];
    } else {
        HelpPramodel.postmodel.chengKe = 0;
    }
    if (model2.tagflag) {
        HelpPramodel.postmodel.buJiMianChengKe = 1;
    } else {
        HelpPramodel.postmodel.buJiMianChengKe = 0;
    }
    
    
    
    InsuredModel *model3 = allModel.dataSource[3];
    if ([model3.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.daoQiang = 1;
    } else {
        HelpPramodel.postmodel.daoQiang = 0;
    }
    if (model3.tagflag) {
        HelpPramodel.postmodel.buJiMianDaoQiang = 1;
    } else {
        HelpPramodel.postmodel.buJiMianDaoQiang = 0;
    }
    
    
    InsuredModel *model4 = allModel.dataSource[4];
    if ([model4.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.cheSun = 1;
    } else {
        HelpPramodel.postmodel.cheSun = 0;

    }
    if (model4.tagflag) {
        HelpPramodel.postmodel.buJiMianCheSun = 1;

    } else {
        HelpPramodel.postmodel.buJiMianCheSun = 0;

    }
    
    
    InsuredModel *model5 = allModel.dataSource[5];
    if ([model5.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.huaHen = [model5.price integerValue];
    } else {
        HelpPramodel.postmodel.huaHen = 0;
    }
    if (model5.tagflag) {
        HelpPramodel.postmodel.buJiMianHuaHen = 1;
    } else {
        HelpPramodel.postmodel.buJiMianHuaHen = 0;
    }
    
    
    InsuredModel *model6 = allModel.dataSource[6];
    if ([model6.select isEqualToString:@"1"]) {
        if ([model6.price isEqualToString:@"国产玻璃"]) {
            HelpPramodel.postmodel.boLi = 1;
        } else {
            HelpPramodel.postmodel.boLi = 2;
        }
    } else {
        HelpPramodel.postmodel.boLi = 0;
    }
  
    
    
    InsuredModel *model7 = allModel.dataSource[7];
    if ([model7.select isEqualToString:@"1"]) {
        HelpPramodel.postmodel.ziRan = 1;
    } else {
        HelpPramodel.postmodel.ziRan = 0;
    }
    if (model7.tagflag) {
        HelpPramodel.postmodel.buJiMianZiRan = 1;
    } else {
        HelpPramodel.postmodel.buJiMianZiRan = 0;
    }
    
    
    InsuredModel *model8 = allModel.dataSource[8];
    if ([model8.select isEqualToString:@"1"]) {
//        HelpPramodel.postmodel.hcSanFangTeYue = 1;
    } else {
//        HelpPramodel.postmodel.hcSanFangTeYue = 0;
    }
    

    
    QuotationListVC  *QuotationVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"QuotationVC"];
    QuotationVC.inforModel = self.inforModel;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:QuotationVC animated:YES];

}

//险种说明
- (IBAction)xianzhongActin:(UIButton *)sender {
    MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
    myWebVC.type = @"4";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWebVC animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTableView beginUpdates];
    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = ((TheW - 20) / 355.0 * 180) + 20 + 300 + 15 + 3;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    AllinsuredModel *model = self.dataSource[section];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TheW, 41)];
    lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
    lab.text = [NSString stringWithFormat:@"   %@", model.title];
    lab.textColor = APPblackColor;
    lab.font = [UIFont systemFontOfSize:13];
    return lab;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AllinsuredModel *model = self.dataSource[section];
    if (section == 1) {
        if (!self.tuozhan) {
            return model.dataSource.count;
        } else {
            return 5;
        }
    }
    return model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InsuredListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InsuredCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AllinsuredModel *model = self.dataSource[indexPath.section];
    InsuredModel *modelList = model.dataSource[indexPath.row];
    [cell showData:modelList];
    WS(weakSelf);
    [cell setMyBlock:^(UIButton *sender){
        if (sender.tag == 100) {
            NSIndexPath *path = [weakSelf getIndexWith:sender];
            InsuredModel *model = [weakSelf getModelWith:sender];

            if (path.section == 0) {
                if ([model.select isEqualToString:@"0"]) {
                    model.select = @"0";

                } else {
                    model.select = @"1";

                }
            
            }
            if ([model.select isEqualToString:@"0"]) {
                model.select = @"1";
                if (path.section == 1 && path.row == 4) {
                    weakSelf.tuozhan = NO;
                    [weakSelf updateModel];
                    [weakSelf.myTableView reloadData];
                }
            } else {
                model.select = @"0";
                model.tagflag = 0;
                if (path.section == 1 && path.row == 4) {
                    weakSelf.tuozhan = YES;
                    [weakSelf updateModel];
                    [weakSelf.myTableView reloadData];
                }
            }
            [weakSelf.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

        } else {
            InsuredListCell *cell = (InsuredListCell *)sender.superview.superview.superview.superview;
            NSIndexPath *path = [self.myTableView indexPathForCell:cell];
            AllinsuredModel *models = self.dataSource[path.section];
            InsuredModel *model = models.dataSource[path.row];
            if (model.tagflag) {
                model.tagflag = 0;
            } else {
                model.tagflag = 1;
                model.select = @"1";
                if (path.section == 1 && path.row == 4) {
                    weakSelf.tuozhan = NO;
                    [weakSelf.myTableView reloadData];
                }
            }
            [weakSelf.myTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        AllinsuredModel *modelS =  self.dataSource[indexPath.section];
        InsuredModel *model = modelS.dataSource[indexPath.row];
        if ([model.insuredAmount containsString:@","]) {
            NSArray *prciceArray = [model.insuredAmount componentsSeparatedByString:@","];
            NSMutableArray *dicPriceArray = [NSMutableArray array];
            for (NSString *price in prciceArray) {
                NSDictionary *dic = @{@"price":price};
                [dicPriceArray addObject:dic];
            }
            
            SexAlterView *sexAV = [SexAlterView creatSexAlterViewWith:dicPriceArray WithKey:@[@"price"]];
            sexAV.titleLab.text = @"请选择额度或类型";
            [sexAV showCancle:nil confirm:^(HZLocation *senderS) {
                model.price = senderS.state;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
    }
}

- (void)updateModel {
    AllinsuredModel *model = self.dataSource[1];
    NSMutableArray *array = model.dataSource;
    NSArray *subarry = [array subarrayWithRange:NSMakeRange(5, 6)];
    for (InsuredModel *model in subarry) {
        model.select = @"0";
        model.tagflag = 0;
    }
}

- (InsuredModel *)getModelWith:(UIButton *)sender {
    NSIndexPath *path = [self getIndexWith:sender];
    AllinsuredModel *model = self.dataSource[path.section];
    InsuredModel *modelS = model.dataSource[path.row];
    return modelS;
}


- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    InsuredListCell *cell = (InsuredListCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}


- (NSDate *)getDateWith:(NSString *)dateStr With:(NSString *)formatStr {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formatStr;
    NSDate *date = [format dateFromString:dateStr];
    return date;
}

- (void)dealloc
{
    MyLog(@"-InsuredPlanViewController-释放");
    HelpPramodel.postmodel.transferDate = nil;
    HelpPramodel.postmodel.moldName = nil;
    HelpPramodel.carDetailType = nil;
    HelpPramodel.postmodel.transferDate = nil;
    HelpPramodel.postmodel.registerDate = nil;
    HelpPramodel.postmodel.carVin = nil;
    HelpPramodel.postmodel.engineNo = nil;
    HelpPramodel.postmodel.forceTax = nil;
    HelpPramodel.postmodel.forceTimeStamp = nil;
    HelpPramodel.postmodel.bizTimeStamp = nil;
    
    
    HelpPramodel.postmodel.seatCount = nil;
    HelpPramodel.postmodel.autoMoldCode = nil;
    HelpPramodel.postmodel.exhaustScale = nil;
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
