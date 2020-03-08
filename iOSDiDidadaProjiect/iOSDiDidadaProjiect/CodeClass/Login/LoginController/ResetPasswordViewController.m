//
//  ResetPasswordViewController.m
//  LLLL
//
//  Created by 敲代码mac1号 on 16/7/12.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()<UITextFieldDelegate>
{
    NSInteger _index;
    BOOL isBool;
}

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;

@property (weak, nonatomic) IBOutlet UIButton *getButton;

@property (weak, nonatomic) IBOutlet UITextField *verifyTF;

@property (nonatomic , strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *firstPassWord;
@property (weak, nonatomic) IBOutlet UITextField *secondPassWord;

@end

@implementation ResetPasswordViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:UIStatusBarAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.userNameTF.delegate = self;
    self.verifyTF.delegate = self;

    self.userNameTF.keyboardType = UIKeyboardTypeNumberPad;

  }
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getVerification:(UIButton *)sender {
    if ([self compare]) {
        return;
    }
    sender.enabled = NO;
    [self attAction];
    NSMutableDictionary *pram = @{@"mobile":self.userNameTF.text}.mutableCopy;
    
    [APIManager GetCodeWithParameters:pram success:^(id data) {
        
        [MBProgressHUD showMessage:@"验证码已发送" toView:nil];
    } failure:^(NSError *error) {
        sender.enabled = YES;
        
    }];
}

- (IBAction)quedingAction:(UIButton *)sender {
    if ([self comepareCode]) {
        return;
    }
    NSMutableDictionary *pram = @{@"mobile":self.userNameTF.text,
                                  @"password":self.firstPassWord.text,
                                  @"loginCode":self.verifyTF.text}.mutableCopy;
        
    [APIManager RegisterWithParameters:pram success:^(id data) {

        [MBProgressHUD showMessage:@"注册成功" toView:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
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

    return NO;
}


- (BOOL)comepareCode {
    if (self.userNameTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入手机号码" toView:nil];
        return YES;
    }
    
    if (self.userNameTF.text.length != 11 || ![self.userNameTF.text hasPrefix:@"1"]) {
        [MBProgressHUD showMessage:@"输入的手机号码有误" toView:nil];
        return YES;
    }
    
    if (self.verifyTF.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入验证码" toView:nil];
        return YES;
    }
    if (self.firstPassWord.text.length == 0) {
        [MBProgressHUD showMessage:@"请输入密码" toView:nil];
        return YES;
    }
    
    if (self.secondPassWord.text.length == 0) {
        [MBProgressHUD showMessage:@"请确认密码" toView:nil];
        return YES;
    }
    
    if (![self.secondPassWord.text isEqualToString:self.firstPassWord.text]) {
        [MBProgressHUD showMessage:@"两次密码不一致" toView:nil];
        return YES;
    }
    
    
    if (self.secondPassWord.text.length < 6 || self.secondPassWord.text.length > 20 || [HelpManager  IsChinese:self.secondPassWord.text] || [HelpManager isHaveIllegalChar:self.firstPassWord.text] ) {
        [MBProgressHUD showMessage:@"密码为6-20位数字及字母的组成" toView:nil];
        return YES;
    }
    

    return NO;
}


- (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)@_+ "];
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


- (IBAction)finishAction:(UIButton *)sender {
    if ([self comepareCode]) {
        return;
    };
  
}




- (void)attAction
{
    _index = 60;
    //启动定时器
    NSTimer *testTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(timeAction:)
                                                        userInfo:nil
                                                         repeats:YES];
    [testTimer fire];//
    [[NSRunLoop currentRunLoop] addTimer:testTimer forMode:NSDefaultRunLoopMode];
    self.timer = testTimer;
}


//每隔1秒 调用一次
- (void)timeAction:(NSTimer *)timer
{
    _index--;
    NSString *again_str = [NSString stringWithFormat:@"%lds",(long)_index];
    self.getButton.titleLabel.text = again_str;
    if (_index <= 0) {
        //invalidate  终止定时器
        [self.getButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.getButton.enabled = YES;
        [timer invalidate];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.getButton setTitle:[NSString stringWithFormat:@"%lds",(long)_index] forState:UIControlStateNormal];
        });
    }
}

#pragma -mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //[self compare];
    [textField resignFirstResponder];
    return YES;
}


- (void)dealloc
{
    MyLog(@"-ResetPasswordViewController-释放");
    
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
