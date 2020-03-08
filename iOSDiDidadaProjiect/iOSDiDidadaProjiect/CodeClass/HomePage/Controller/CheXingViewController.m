//
//  CheXingViewController.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/20.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "CheXingViewController.h"
#import "VehicleInfoViewController.h"
#import "PeiSongInforVC.h"
#import "CarDatainforViewController.h"

@interface CheXingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *xiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *daBtn;

@end

@implementation CheXingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.xiaoBtn.layer.cornerRadius = 150 / 2.0;
    self.daBtn.layer.cornerRadius = 150 / 2.0;
    
    self.xiaoBtn.layer.masksToBounds = YES;
    self.daBtn.layer.masksToBounds = YES;
    [self creatUI];
}



- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"车型选择";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
}

- (IBAction)xiaoAction:(UIButton *)sender {
    VehicleInfoViewController *VehicleInfoVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"VehicleInfoVC"];
    HelpPramodel.postmodel.renewalCarType = @"0";

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VehicleInfoVC animated:YES];
}

- (IBAction)huocheAction:(UIButton *)sender {
    VehicleInfoViewController *VehicleInfoVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"VehicleInfoVC"];
    VehicleInfoVC.type = YES;
    HelpPramodel.postmodel.renewalCarType = @"1";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VehicleInfoVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-CheXingViewController-释放");
    
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
