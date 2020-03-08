//
//  OwnerInforViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "OwnerInforViewController.h"
#import "InsurancePeopleInforVC.h"


@interface OwnerInforViewController () {
    NSString *ownerID;
    NSString *ownerName;
    NSString *ownerPhone;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *idTf;
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation OwnerInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
    [self creatUI];
}

- (void) creatUI{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"车主信息";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
}

- (IBAction)nextAction:(UIButton *)sender {
    ownerID = self.idTf.text;
    ownerName = self.nametf.text;
    ownerPhone = self.phoneText.text;
    if (ownerID.length == 0) {
        [MBProgressHUD showMessage:@"请输入身份证号" toView:nil];
        return;
    }
    
    if (![HelpManager judgeIdentityStringValid:ownerID]) {
        [MBProgressHUD showMessage:@"请输入正确的身份证号" toView:nil];
        return;
    }
    
    if (ownerName.length == 0) {
        [MBProgressHUD showMessage:@"请输入车主姓名" toView:nil];
        return;
    }

    if (ownerPhone.length != 11) {
        [MBProgressHUD showMessage:@"请输入正确手机号" toView:nil];
        return;
    }
    
    HelpPramodel.postmodel.idCard = ownerID;
    HelpPramodel.postmodel.carOwnersName = ownerName;
    HelpPramodel.postmodel.carOwnerMobile = ownerPhone;
    HelpPramodel.postmodel.ownerIdCardType = @"1";
    
    InsurancePeopleInforVC *pushVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"InsurancePeopleInforVC"];
    pushVC.senderModel = self.senderModel;
    [self.navigationController pushViewController:pushVC animated:YES];
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

- (void)dealloc
{
    HelpPramodel.postmodel.idCard = nil;
    HelpPramodel.postmodel.carOwnersName = nil;
    HelpPramodel.postmodel.carOwnerMobile = nil;
    HelpPramodel.postmodel.ownerIdCardType = nil;
    
    MyLog(@"-OwnerInforViewController-释放");
    
}

@end
