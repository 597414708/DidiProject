//
//  LoginViewController.m
//  Smart
//
//  Created by 敲代码mac1号 on 16/6/28.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "LoginViewController.h"
#import<CommonCrypto/CommonDigest.h>
#import "ResetPasswordViewController.h"
#import "MainTabBarController.h"
#import "ChangePasViewController.h"

#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@property (weak, nonatomic) IBOutlet UIButton *closeButon;
@property (nonatomic , strong) MBProgressHUD *hud;
@end

@implementation LoginViewController





- (IBAction)changeImage:(UIButton *)sender {
    self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
    self.closeButon.selected = !self.closeButon.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view from its nib.

    self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;
}



- (IBAction)loginAction:(UIButton *)sender {
    if ([self compare]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *pram = @{@"mobile": self.userNameTF.text,
                                  @"password": self.passwordTF.text,
                                  @"loginType":@"0"}.mutableCopy;
    
    [APIManager LogonWithParameters:pram success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary *dic = data;
        NSString *code = [NSString stringWithFormat:@"%@", dic[@"code"]];
        NSDictionary *dataS = dic[@"data"];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showMessage:@"登录成功" toView:nil];
            NSString *token = dataS[@"token"];
            NSString *userId = [NSString stringWithFormat:@"%@", dataS[@"id"]];
            NSString *headImage = [NSString stringWithFormat:@"%@", dataS[@"userHead"]];
            
            NSString *nickName = [NSString stringWithFormat:@"%@", dataS[@"nickName"]];


            [userDef setObject:token forKey:@"Cookie"];
            [userDef setObject:userId forKey:USERID];
            [userDef setObject:headImage forKey:HeadImage];
            [userDef setObject:nickName forKey:NickName];

            MainTabBarController *mainTabBarVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MainTabBarVC"];
            [self presentViewController:mainTabBarVC animated:YES completion:nil];
        } else {
            [MBProgressHUD showMessage:dic[@"message"] toView:nil];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
}



- (IBAction)back:(UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (IBAction)registerAction:(UIButton *)sender {
    ResetPasswordViewController *resetVC = [[ResetPasswordViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resetVC animated:YES];
}


- (IBAction)forgetAction:(UIButton *)sender {
    ChangePasViewController *resetVC = [[ChangePasViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:resetVC animated:YES];
}


- (BOOL)compare {
    if (self.userNameTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入手机号码" toView:nil];
        return YES;
    }
    
    if (self.userNameTF.text.length != 11 || ![self.userNameTF.text hasPrefix:@"1"]) {
        [MBProgressHUD showMessage:@"输入的手机号码有误" toView:nil];
        return YES;
    }
    
    if (self.passwordTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入密码" toView:nil];
        return YES;
    }
    
    if (self.passwordTF.text.length < 6 || self.passwordTF.text.length > 20 || [self IsChinese:self.passwordTF.text] || [self isHaveIllegalChar:self.passwordTF.text] ) {
        [MBProgressHUD showMessage:@"密码为6-20位数字及字母的组成" toView:nil];
        return YES;
    }
    
    return NO;
}

- (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location < str.length;
}

//判断是否有中文
-(BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-LoginViewController-释放");
    
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
