//
//  VehicleInfoViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "VehicleInfoViewController.h"
#import "JFLocation.h"
#import "JFAreaDataManager.h"
#import "AreaView.h"

#import "OwnerInforViewController.h"
#import "SexAlterView.h"
#import "HZLocation.h"

#import "ChooseCityView.h"

#import "SelectIndexCell.h"
#import "HuoCheBaojiaVC.h"
#import "InsuranceOrderDetailVC.h"

#import "CarDatainforViewController.h"

@interface VehicleInfoViewController () <UITableViewDelegate, UITableViewDataSource>  {
    NSString *citycode;
    NSString *citycodeII;

    NSString *provinceCode;
    NSString *licenseNo;
    NSString *ownerMobile;
}

@property (weak, nonatomic) IBOutlet UILabel *cityNameLab;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UITextField *carNum;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *proviceLab;
@property (nonatomic, strong) NSMutableArray *cityArray;

@property (weak, nonatomic) IBOutlet UITableView *myTablewView;
@property (weak, nonatomic) IBOutlet UITextField *chejiaTf;

@property (weak, nonatomic) IBOutlet UITextField *fadongjiTf;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabII;
@property (nonatomic, assign) NSInteger index;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;

@end

@implementation VehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData];

    if (self.arrea && self.numCode) {
        self.areaLab.text = self.arrea;
        self.carNum.text = self.numCode;
    }
}

- (void)viewDidLayoutSubviews {
    [self.myTablewView beginUpdates];

    CGRect headerFrame = self.myTablewView.tableHeaderView.frame;
    headerFrame.size.height = TheW / 375.0 * 135;
    //修改tableHeaderView的frame
    self.myTablewView.tableHeaderView.frame = headerFrame;
    CGRect headerFrameI = self.myTablewView.tableFooterView.frame;
    headerFrameI.size.height = TheH - TheW / 375.0 * 135;
    self.myTablewView.tableFooterView.frame = headerFrameI;
    [self.myTablewView endUpdates];

}


- (void) creatUI{
    self.index = 0;
    self.myTablewView.delegate = self;
    self.myTablewView.dataSource = self;
    self.myTablewView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTablewView.rowHeight = 52;
    [self.myTablewView registerNib:[UINib nibWithNibName:@"SelectIndexCell" bundle:nil] forCellReuseIdentifier:@"SelectIndexCell"];
    self.carNum.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.chejiaTf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.fadongjiTf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    if (self.model) {
        self.carNum.text = [self.model.licenseNo substringWithRange:NSMakeRange(1, self.model.licenseNo.length - 1)];
        self.areaLab.text = [self.model.licenseNo substringWithRange:NSMakeRange(0, 1)];
        self.chejiaTf.text = self.model.carVin;
        self.fadongjiTf.text = self.model.engineNo;
    }
    self.areaView.layer.cornerRadius = 2;
    self.areaView.layer.masksToBounds = YES;
    
    self.nextBtn.layer.cornerRadius = 4;
    self.nextBtn.layer.masksToBounds = YES;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"车险报价";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
}


- (void)creatData {
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager BaoxianProvinceListListWithParameters:nil success:^(id data) {
        [[HelpManager shareHelpManager].provincesArray removeAllObjects];
        NSArray *array = data;
        [[HelpManager shareHelpManager].provincesArray addObjectsFromArray:array];
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)choseProviceAction:(UIButton *)sender {
    
    if ([HelpManager shareHelpManager].provincesArray.count == 0) {
        return;
    }
    NSArray *keyArray = @[@"children", @"name", @"name", @"cityCode"];
    ChooseCityView *cityView = [ChooseCityView creatChooseCityViewWithDataSource:[HelpManager shareHelpManager].provincesArray WithKey:keyArray];
    [cityView showCancle:nil confirm:^(HZLocation *sender) {
        self.proviceLab.text = [NSString stringWithFormat:@"%@ %@",sender.state, sender.city];
        citycode = [NSString stringWithFormat:@"%@", sender.city_code];
        
    }];
}

- (IBAction)chooseCityAction:(UIButton *)sender {
    if ([HelpManager shareHelpManager].provincesArray.count == 0) {
        return;
    }
    NSArray *keyArray = @[@"children", @"name", @"name", @"cityCode"];
    ChooseCityView *cityView = [ChooseCityView creatChooseCityViewWithDataSource:[HelpManager shareHelpManager].provincesArray WithKey:keyArray];
    [cityView showCancle:nil confirm:^(HZLocation *sender) {
        self.cityNameLabII.text = [NSString stringWithFormat:@"%@ %@",sender.state, sender.city];
        citycodeII = [NSString stringWithFormat:@"%@", sender.city_code];
    }];
}


- (IBAction)choseAreaAction:(UIButton *)sender {
    [self.phoneNum resignFirstResponder];
    [self.carNum resignFirstResponder];
    AreaView *view = [AreaView shareAreaViewWith:self.areaLab.text];
    
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view setAreaBlock:^(NSString *str){
        self.areaLab.text = str;
    }];
}

- (IBAction)nextAction:(id)sender {
    
    ownerMobile = self.phoneNum.text;
    if (citycode.length == 0) {
        [MBProgressHUD showMessage:@"请选择投保城市" toView:nil];
        return;
    }
    
    if (self.carNum.text.length != 6) {
        [MBProgressHUD showMessage:@"请输入正确车牌号" toView:nil];
        return;
    } else {
        licenseNo = [NSString stringWithFormat:@"%@%@", self.areaLab.text, self.carNum.text];
        licenseNo = [licenseNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if (![HelpManager checkCarNumber:licenseNo]) {
        [MBProgressHUD showMessage:@"请输入正确车牌号" toView:nil];
        return;
    }
    
    NSMutableDictionary *dicMuc = @{@"licenseNo":licenseNo,
                                    @"cityCode":citycode,
                                    @"showOrg":@"1",
                                    @"canShowNo":@"1"
                                    }.mutableCopy;
    HelpPramodel.postmodel.cityCode = citycode;
    [self pushVC:dicMuc];
}

- (void)pushVC:(NSMutableDictionary *)pram {
    if (self.type) {
        CarDatainforViewController *carDatainforVC =[kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarDatainforVC"];
        carDatainforVC.tag = 2;
        if (!self.model) {
            self.model = [[CarInforModel alloc] init];
        }
        self.model.carVin = self.chejiaTf.text;
        self.model.engineNo = self.fadongjiTf.text;
        self.model.licenseNo = licenseNo;
        carDatainforVC.model = self.model;

        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:carDatainforVC animated:YES];
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [APIManager BaoxianCarInfoWithParameters:pram success:^(id responseObject) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSDictionary *dics = responseObject;
            NSString *code = [NSString stringWithFormat:@"%@", dics[@"code"]];
            NSDictionary *data = dics[@"data"];
            if ([code isEqualToString:@"1"]) {
                NSDictionary *dic = data;
                InsuranceOrderDetailVC *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"InsuranceOrderDetailVC"];
                VC.senderDic = dic.mutableCopy;
                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:VC animated:YES];
            } else {
                CarDatainforViewController *carDatainforVC =[kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarDatainforVC"];
                carDatainforVC.tag = 2;
                if (!self.model) {
                    self.model = [[CarInforModel alloc] init];
                }
                NSString *carVin = dics[@"data"][@"userInfo"][@"carVin"];
                NSString *modleName =  dics[@"data"][@"userInfo"][@"modleName"];
                NSString *registerDate =  dics[@"data"][@"userInfo"][@"registerDate"];
                NSString *engineNo =  dics[@"data"][@"userInfo"][@"engineNo"];

                self.model.carVin = carVin.length > 0 ? carVin:self.chejiaTf.text;
                self.model.engineNo = engineNo.length > 0 ? engineNo:self.fadongjiTf.text;;
                self.model.licenseNo = licenseNo;
                self.model.brand = modleName;
                self.model.regTime = registerDate;
                carDatainforVC.model = self.model;

                self.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:carDatainforVC animated:YES];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
}


- (IBAction)finishAction:(UIButton *)sender {
    
    if (citycodeII.length == 0) {
        [MBProgressHUD showMessage:@"请选择投保城市" toView:nil];
        return;
    }
    
    if (self.chejiaTf.text.length != 17 ) {
        [MBProgressHUD showMessage:@"请输入正确车架号" toView:nil];
        return;
    }
    
    if (self.fadongjiTf.text.length == 0 ) {
        [MBProgressHUD showMessage:@"请输入正确发动机号" toView:nil];
        return;
    }
    
    NSMutableDictionary *dicMuc = @{@"engineNo":self.fadongjiTf.text,
                                    @"cityCode":citycodeII,
                                    @"showOrg":@"1",
                                    @"carVin":self.chejiaTf.text,
                                    @"canShowNo":@"1"
                                    }.mutableCopy;
    HelpPramodel.postmodel.cityCode = citycodeII;
    [self pushVC:dicMuc];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectIndexCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showData:self.index];
    WS(weakSelf);
    [cell setMyBlock:^(NSInteger sender) {
          weakSelf.myScrollview.contentOffset =  CGPointMake(sender * TheW, 0);
    }];
  
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-VehicleInfoViewController-释放");
    HelpPramodel.postmodel.cityCode = nil;
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
