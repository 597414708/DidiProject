//
//  InsuranceOrderDetailVC.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "InsuranceOrderDetailVC.h"
#import "CollectionTableViewCell.h"
#import "ListDataTableViewCell.h"
#import "InsuranceDetailModel.h"
#import "CoverageModel.h"
#import "PayTypeModel.h"
#import "PayListTableViewCell.h"
#import "MyWebViewController.h"
#import "PriceListModel.h"
#import "UserInfo.h"
#import "InsuredPlanViewController.h"

@interface InsuranceOrderDetailVC ()<UITableViewDelegate, UITableViewDataSource> {
}


@property (weak, nonatomic) IBOutlet UITableView *myTabView;

@property (strong, nonatomic) InsuranceDetailModel *detailModel;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UILabel *licenseNoLab;
@property (weak, nonatomic) IBOutlet UILabel *modleNameLab;

@property (weak, nonatomic) IBOutlet UILabel *licenseOwnerLab;
@property (weak, nonatomic) IBOutlet UILabel *engineNoLab;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLab;
@property (weak, nonatomic) IBOutlet UILabel *carVinLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;

@property (nonatomic, strong) UserInfo *inforModel;

@end

@implementation InsuranceOrderDetailVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.detailModel = [[InsuranceDetailModel alloc] init];
    self.detailModel = [InsuranceDetailModel mj_objectWithKeyValues:self.senderDic];
    self.inforModel = self.detailModel.userInfo;
    [self updateUI:self.detailModel.userInfo];
    [self.myTabView reloadData];
    [self creatUI];
//    [self creatData];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTabView beginUpdates];
    CGRect headerFrame = self.myTabView.tableHeaderView.frame;
    headerFrame.size.height = ((TheW - 20) / 355.0 * 180) + 20 + 100;
    //修改tableHeaderView的frame
    self.myTabView.tableHeaderView.frame = headerFrame;
    [self.myTabView endUpdates];
    
}

- (IBAction)finishAction:(UIButton *)sender {
    

    
    InsuredPlanViewController *InsuredPlanVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"InsuredPlanVC"];
    InsuredPlanVC.inforModel = self.inforModel;
    [self.navigationController pushViewController:InsuredPlanVC animated:YES];
}

- (void)updateUI:(UserInfo *)model {
    self.licenseNoLab.text = model.licenseNo;
    self.modleNameLab.text = model.modleName;
    self.carVinLab.text = [NSString stringWithFormat:@"车架号 %@", model.carVin];
    self.engineNoLab.text = [NSString stringWithFormat:@"发动机号 %@", model.engineNo];
    self.registerDateLab.text = [NSString stringWithFormat:@"%@", model.registerDate];
    self.licenseOwnerLab.text = [NSString stringWithFormat:@"%@", model.licenseOwner];
    if ([self checkProductDate:model.businessExpireDate]) {
        self.stateLab.text = @"未到期";
    } else {
        self.stateLab.text = @"已到期";

    }
}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"查询详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.topBgView.layer.cornerRadius = 4;
    self.topBgView.layer.masksToBounds = YES;
    
    [self.myTabView registerNib:[UINib nibWithNibName:@"CollectionTableViewCell" bundle:nil] forCellReuseIdentifier:@"CollectionTableViewCell"];
    
    [self.myTabView registerNib:[UINib nibWithNibName:@"ListDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListDataTableViewCell"];
    
    self.myTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTabView.delegate = self;
    self.myTabView.dataSource = self;
    self.myTabView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTabView.rowHeight = UITableViewAutomaticDimension;
}

- (BOOL)checkProductDate: (NSString *)tempDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:tempDate];
    
    // 判断是否大于当前时间
    if ([date earlierDate:[NSDate date]] != date) {
        
        return true;
    } else {
        
        return false;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return self.detailModel.saveQuote.priceList.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ListDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListDataTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.classNameLab.text = @"商业险到期时间";
            cell.contentLab.text = self.detailModel.userInfo.businessExpireDate;
        } else if (indexPath.row == 1) {
            cell.classNameLab.text = @"交强险到期时间";
            cell.contentLab.text = self.detailModel.userInfo.forceExpireDate;

        } else if (indexPath.row == 2) {
            cell.classNameLab.text = @"上年投保公司";
            cell.contentLab.text = [NSString stringWithFormat:@"%@", self.detailModel.saveQuote.source];
        } else if (indexPath.row == 3) {
            cell.classNameLab.text = @"交强险保单号";
            cell.contentLab.text = [NSString stringWithFormat:@"%@", self.detailModel.userInfo.forceNo];
        }else if (indexPath.row == 4) {
            cell.classNameLab.text = @"商业险保单号";
            cell.contentLab.text = [NSString stringWithFormat:@"%@", self.detailModel.userInfo.bizNo];
        }else if (indexPath.row == 5) {
            cell.classNameLab.text = @"机构名称";
            cell.contentLab.text = [NSString stringWithFormat:@"%@", self.detailModel.userInfo.organization];
        }
        return cell;
    } else {
        CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.firstLab.textColor = APPColor;
            cell.secondLab.textColor = APPColor;
            cell.firstLab.text = @"险种";
            cell.secondLab.text = @"保额/责任限额";
        }else {
            cell.firstLab.textColor = APPGrayColor;
            cell.secondLab.textColor = APPGrayColor;
            PriceListModel *models = self.detailModel.saveQuote.priceList[indexPath.row - 1];
            [cell showData:models];
            
        }
        return cell;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = [NSString stringWithFormat:@"   %@", @"分期方式"];
        lab.textColor = Color(51, 51, 51);
        lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
        return lab;
    } else {
        UIView *e = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TheW, 5)];
        e.backgroundColor = kCOLOR_HEX(0xeeeeee);
        return e;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 40;
    }
    return 0.01;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    MyLog(@"-InsuranceOrderDetailVC-释放");
    
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
