//
//  InsurancePeopleInforVC.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "InsurancePeopleInforVC.h"

#import "InsuranceOrderDetailVC.h"
#import "TijiaoShenHeVC.h"

@interface InsurancePeopleInforVC ()
@property (weak, nonatomic) IBOutlet UITextField *baodanNametf;
@property (weak, nonatomic) IBOutlet UITextField *baodanIDtf;
@property (weak, nonatomic) IBOutlet UITextField *bandaoPhonetf;


@property (weak, nonatomic) IBOutlet UITextField *toubaoNametf;
@property (weak, nonatomic) IBOutlet UITextField *toubaoIDtf;
@property (weak, nonatomic) IBOutlet UITextField *toubaoPhonetf;

@end

@implementation InsurancePeopleInforVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    [self creatUI];
}

- (void) creatUI{
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"用户信息";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
}


- (void)getBaoDanData:(InsurancePostModel *)model {
    self.baodanNametf.text = model.carOwnersName;
    self.baodanIDtf.text = model.idCard;
    self.bandaoPhonetf.text = model.carOwnerMobile;
    
}

- (void)getToubaoData:(InsurancePostModel *)model {
    self.toubaoNametf.text = model.carOwnersName;
    self.toubaoIDtf.text = model.idCard;
    self.toubaoPhonetf.text = model.carOwnerMobile;
}


- (IBAction)baodanAction:(UISwitch *)sender {
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    [firstResponder resignFirstResponder];
    [self changeBaodanUserInteractionEnabledWith:sender.on];

    if (sender.on) {
        [self getBaoDanData:HelpPramodel.postmodel];
    } else {
        [self getBaoDanData:nil];
    }
}

- (IBAction)toubaoAction:(UISwitch *)sender {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    [firstResponder resignFirstResponder];
    
    [self changeToubaoUserInteractionEnabledWith:sender.on];
    if (sender.on) {
        [self getToubaoData:HelpPramodel.postmodel];
    } else {
        [self getToubaoData:nil];
    }
}

- (void)changeBaodanUserInteractionEnabledWith:(BOOL)tag {
    self.baodanNametf.userInteractionEnabled = !tag;
    self.baodanIDtf.userInteractionEnabled = !tag;
    self.bandaoPhonetf.userInteractionEnabled = !tag;
}

- (void)changeToubaoUserInteractionEnabledWith:(BOOL)tag {
    self.toubaoNametf.userInteractionEnabled = !tag;
    self.toubaoIDtf.userInteractionEnabled = !tag;
    self.toubaoPhonetf.userInteractionEnabled = !tag;
}


- (IBAction)finishAction:(UIButton *)sender {
    if (self.baodanNametf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入保单人姓名" toView:self.view];
        return;
    }
    
    if (self.baodanIDtf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入保单人身份证" toView:self.view];
        return;
    }
    
    if (![HelpManager judgeIdentityStringValid:self.baodanIDtf.text]) {
        [MBProgressHUD showMessage:@"保单人身份证号有误" toView:nil];
        return;
    }
    
    if (self.bandaoPhonetf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入保单人手机号" toView:self.view];
        return;
    }
    
    if (self.toubaoNametf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入投保人姓名" toView:self.view];
        return;
    }
    
    if (self.toubaoIDtf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入投保人身份证号" toView:self.view];
        return;
    }
    
    if (![HelpManager judgeIdentityStringValid:self.toubaoIDtf.text]) {
        [MBProgressHUD showMessage:@"投保人身份证号有误" toView:nil];
        return;
    }
    
    if (self.toubaoPhonetf.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入投保人手机号" toView:self.view];
        return;
    }
    
    
    HelpPramodel.postmodel.insuredIdCard = self.baodanIDtf.text;
    HelpPramodel.postmodel.insuredName = self.baodanNametf.text;
    HelpPramodel.postmodel.insuredMobile = self.bandaoPhonetf.text;
    HelpPramodel.postmodel.insuredIdType = @"1";
    
    HelpPramodel.postmodel.holderIdCard = self.toubaoIDtf.text;
    HelpPramodel.postmodel.holderName = self.toubaoNametf.text;
    HelpPramodel.postmodel.holderMobile = self.toubaoPhonetf.text;
    HelpPramodel.postmodel.holderIdType = @"1";
    TijiaoShenHeVC *senderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"TijiaoShenHeVC"];
    senderVC.senderModel = self.senderModel;
    [self.navigationController pushViewController:senderVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
    HelpPramodel.postmodel.insuredIdCard = nil;
    HelpPramodel.postmodel.insuredName = nil;
    HelpPramodel.postmodel.insuredMobile = nil;
    HelpPramodel.postmodel.insuredIdType = nil;
    
    HelpPramodel.postmodel.holderIdCard = nil;
    HelpPramodel.postmodel.holderName = nil;
    HelpPramodel.postmodel.holderMobile = nil;
    HelpPramodel.postmodel.holderIdType = nil;
    
    MyLog(@"-InsurancePeopleInforVC-释放");
    
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
