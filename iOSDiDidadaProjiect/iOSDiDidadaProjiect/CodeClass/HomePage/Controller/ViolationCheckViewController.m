//
//  ViolationCheckViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ViolationCheckViewController.h"
#import "AreaView.h"
#import "CityWithIdPickView.h"
#import "HZLocation.h"
#import "ChooseCityView.h"
#import "WeizhangModel.h"
#import "ViolationListViewController.h"

@interface ViolationCheckViewController () {
    NSString *city;
    NSString *licenSeNo;
    NSString *framNo;
    NSString *engineNo;
}

@property (weak, nonatomic) IBOutlet UITextField *chePaitf;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UITextField *fadongjiTf;
@property (weak, nonatomic) IBOutlet UITextField *chejiaTf;
@property (weak, nonatomic) IBOutlet UIView *areaView;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViolationCheckViewController

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
    [self creatData];
}
- (void) creatUI{
    self.areaView.layer.cornerRadius = 2;
    self.areaView.layer.masksToBounds = YES;
    
    self.nextBtn.layer.cornerRadius = 4;
    self.nextBtn.layer.masksToBounds = YES;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"违章查询";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    if (self.model) {
        
        self.chejiaTf.text = self.model.carVin;
        self.chePaitf.text = [self.model.licenseNo substringWithRange:NSMakeRange(1, self.model.licenseNo.length - 1)];
        self.areaLab.text = [self.model.licenseNo substringWithRange:NSMakeRange(0, 1)];
        self.fadongjiTf.text = self.model.engineNo;
    }
    self.chePaitf.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;

}

- (void)creatData {
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager WeizhangCityListListWithParameters:nil success:^(id data) {
        NSArray *array = data;
        [[HelpManager shareHelpManager].cityArray addObjectsFromArray:array];
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)areaAction:(UIButton *)sender {
    [self.chePaitf resignFirstResponder];
    [self.fadongjiTf resignFirstResponder];
    [self.chejiaTf resignFirstResponder];
    AreaView *view = [AreaView shareAreaViewWith:self.areaLab.text];

    [[UIApplication sharedApplication].keyWindow addSubview:view];

    [view setAreaBlock:^(NSString *str){
        self.areaLab.text = str;
    }];
   
}

- (IBAction)finishAction:(UIButton *)sender {

    framNo = self.chejiaTf.text;
    engineNo = self.fadongjiTf.text;
    
    if (self.chePaitf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入车牌号" toView:nil];
        return;
    } else {
        licenSeNo = [NSString stringWithFormat:@"%@%@", self.areaLab.text, self.chePaitf.text];
    }

    if (city.length == 0) {
        [MBProgressHUD showMessage:@"请选择城市" toView:nil];
        return;
    }
    
    if (framNo.length == 0) {
        [MBProgressHUD showMessage:@"请输入车辆识别号" toView:nil];
        return;
    }
    
    if (engineNo.length == 0) {
        [MBProgressHUD showMessage:@"请输入发动机号" toView:nil];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    NSMutableDictionary *dicMu = @{@"city":city,
                                   @"licenseNo":licenSeNo,
                                   @"frameNo":framNo,
                                   @"engineNo":engineNo
                                   }.mutableCopy;
    [APIManager WeizhangInfoListWithParameters:dicMu success:^(id data) {
        NSArray *dicArray = data;
        self.dataSource = [WeizhangModel mj_objectArrayWithKeyValuesArray:dicArray];
        ViolationListViewController *listVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"ViolationListVC"];
        listVC.titleStr = licenSeNo;
        listVC.dataSource = self.dataSource;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:YES];
        
    } failure:^(NSError *error) {
        
    }];  
}

- (IBAction)selectAddressAction:(UIButton *)sender {
    [self.chePaitf resignFirstResponder];
    [self.fadongjiTf resignFirstResponder];
    [self.chejiaTf resignFirstResponder];
    NSArray *keyArray = @[@"citys", @"province", @"city_name", @"city_code"];
    ChooseCityView *cityView = [ChooseCityView creatChooseCityViewWithDataSource:[HelpManager shareHelpManager].cityArray WithKey:keyArray];
    [cityView showCancle:nil confirm:^(HZLocation *sender) {
        self.addressLab.text = [NSString stringWithFormat:@"%@ %@",sender.state,sender.city];
        city = sender.city_code;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    MyLog(@"-ViolationCheckViewController-释放");    
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
