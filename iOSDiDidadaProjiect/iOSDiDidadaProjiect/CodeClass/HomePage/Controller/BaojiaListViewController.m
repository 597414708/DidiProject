//
//  BaojiaListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/30.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaojiaListViewController.h"
#import "BaojiaListCell.h"
#import "InsurerListmodel.h"
#import "BaojiaModel.h"
#import "BaojiaShibaiVC.h"
#import "BaojiaDetailVC.h"

@interface BaojiaListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UILabel *licenseNoLab;
@property (weak, nonatomic) IBOutlet UILabel *modleNameLab;

@property (weak, nonatomic) IBOutlet UILabel *licenseOwnerLab;
@property (weak, nonatomic) IBOutlet UILabel *engineNoLab;
@property (weak, nonatomic) IBOutlet UILabel *registerDateLab;
@property (weak, nonatomic) IBOutlet UILabel *carVinLab;

@end

@implementation BaojiaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    [self updateUI:self.inforModel];
    
}

- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = (TheW - 20) / 355.0 * 180 + 15;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"精准报价";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.topBgView.layer.cornerRadius = 4;
    self.topBgView.layer.masksToBounds = YES;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 80;
    [self.myTableView registerNib:[UINib nibWithNibName:@"BaojiaListCell" bundle:nil] forCellReuseIdentifier:@"BaojiaListCell"];
}

- (void)updateUI:(UserInfo *)model {
    self.licenseNoLab.text = model.licenseNo;
    self.modleNameLab.text = model.modleName;
    //强险
    self.carVinLab.text = [NSString stringWithFormat:@"交强险起保时间 %@", [HelpManager getDate:HelpPramodel.postmodel.forceTimeStamp With:@"YYYY-MM-dd"]];
    //商业
    self.engineNoLab.text = [NSString stringWithFormat:@"商业险起保时间 %@", [HelpManager getDate:HelpPramodel.postmodel.bizTimeStamp With:@"YYYY-MM-dd"]];
    self.registerDateLab.text = [NSString stringWithFormat:@"%@", model.registerDate];
    self.licenseOwnerLab.text = [NSString stringWithFormat:@"%@", model.licenseOwner];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaojiaListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InsurerListmodel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    WS(weakSelf);
    [cell setMyBlock:^(UIButton *sender) {
        BaojiaListCell *senderCell = (BaojiaListCell *)sender.superview.superview.superview;
        NSIndexPath *path = [weakSelf.myTableView indexPathForCell:senderCell];
        InsurerListmodel *senderModel = weakSelf.dataSource[path.row];
        NSMutableDictionary *dic = @{@"licenseNo":HelpPramodel.postmodel.licenseNo,
                                     @"quoteGroup":senderModel.code,
                                     @"renewalCarType":HelpPramodel.postmodel.renewalCarType
                                     }.mutableCopy;
        if ([senderModel.selectII isEqualToString:@"1"]) {
            [dic setObject:senderModel.code forKey:@"submitGroup"];
        }
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager BaoxianGetPriceWithParameters:dic success:^(id data) {
            NSDictionary *dic = data[@"item"];
            BaojiaModel *model = [[BaojiaModel alloc] init];
            model = [BaojiaModel mj_objectWithKeyValues:dic];
            senderModel.bizTotal = model.bizTotal;
            senderModel.taxTotal = model.taxTotal;
            senderModel.forceTotal = model.forceTotal;
            senderModel.quoteResult = model.quoteResult;
            senderModel.quoteStatus = model.quoteStatus;
            senderModel.submitResult = model.submitResult;
            senderModel.statusMessage = data[@"statusMessage"];
            senderModel.indentId = data [@"indentId"];
            senderModel.priceList = model.priceList;
            if ([HelpPramodel.postmodel.renewalCarType isEqualToString:@"1"]) {
                senderModel.quoteResult =  data[@"statusMessage"];
            }
            [weakSelf.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(NSError *error) {
            
        }];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InsurerListmodel *senderModel = self.dataSource[indexPath.row];
    if (senderModel.statusMessage) {
        if (senderModel.quoteStatus.integerValue > 0) {
            BaojiaDetailVC *senderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaDetailVC"];
            senderVC.inforModel = self.inforModel;
            senderVC.senderModel = senderModel;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:senderVC animated:YES];
        } else {
            BaojiaShibaiVC  *senderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaShibaiVC"];
            senderVC.indentId = senderModel.indentId;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:senderVC animated:YES];
        }
    } else {
        NSMutableDictionary *dic = @{@"licenseNo":HelpPramodel.postmodel.licenseNo,
                                     @"quoteGroup":senderModel.code,
                                     @"renewalCarType":HelpPramodel.postmodel.renewalCarType
                                     }.mutableCopy;
        
        if ([senderModel.selectII isEqualToString:@"1"]) {
            [dic setObject:senderModel.code forKey:@"submitGroup"];
        }
        
        [MBProgressHUD showHUDAddedTo:nil animated:YES];
        [APIManager BaoxianGetPriceWithParameters:dic success:^(id data) {
            NSDictionary *dic = data[@"item"];
            BaojiaModel *model = [[BaojiaModel alloc] init];
            model = [BaojiaModel mj_objectWithKeyValues:dic];
            senderModel.bizTotal = model.bizTotal;
            senderModel.taxTotal = model.taxTotal;
            senderModel.forceTotal = model.forceTotal;
            senderModel.quoteResult = model.quoteResult;
            senderModel.quoteStatus = model.quoteStatus;
            senderModel.submitResult = model.submitResult;
            senderModel.statusMessage = data[@"statusMessage"];
            senderModel.priceList = model.priceList;
            senderModel.indentId = data [@"indentId"];
            if ([HelpPramodel.postmodel.renewalCarType isEqualToString:@"1"]) {
                senderModel.quoteResult =  data[@"statusMessage"];
            }
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } failure:^(NSError *error) {
            
        }];
    }
}


- (void)dealloc
{
    MyLog(@"-BaojiaListViewController-释放");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
