//
//  PersonEditViewController.m
//  IOSSumgoTeaProject
//
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "PersonEditViewController.h"

@interface PersonEditViewController ()<UITextFieldDelegate>

@end

@implementation PersonEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"编辑";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    [self configView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:self.tfEdit];
    
    self.view.backgroundColor = kCOLOR_HEX(0xeeeeee);
    
    [self.tfEdit becomeFirstResponder];
    
    if (self.type == 2 || self.type == 8) {
        self.tfEdit.keyboardType = UIKeyboardTypeNumberPad;
    }
}

-(void)configView
{
    //.导航右边按钮
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.bounds=CGRectMake(0, 0, 30, 30);
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton setTitleColor:APPGrayColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    UIView *mainView = [[UIView alloc]init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@69);
        make.height.equalTo(@50);
    }];
    
    self.tfEdit = [[UITextField alloc]init];
    self.tfEdit.font = [UIFont systemFontOfSize:16];
    self.tfEdit.placeholder = _strPlaceHolder;
    self.tfEdit.delegate = self;
    self.tfEdit.clearButtonMode = UITextFieldViewModeWhileEditing;
    if (_isTel) {
        self.tfEdit.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        self.tfEdit.keyboardType = UIKeyboardTypeDefault;
    }
    [mainView addSubview:self.tfEdit];
    [self.tfEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(mainView).offset(-20);
        make.top.equalTo(@0);
        make.height.equalTo(50);
    }];
    
    if (self.strContent.length>0) {
        self.tfEdit.text = self.strContent;
    }
}


-(void)rightButtonClick:(UIButton *)button
{
    [self.tfEdit resignFirstResponder];
    if (self.tfEdit.text.length == 0  && !self.isAllowEmpty) {
        return;
    }
    if (!self.mudic) {
        if (self.type == 4) {
            if (![HelpManager judgeIdentityStringValid:self.tfEdit.text]) {
                
                [MBProgressHUD showMessage:@"身份证格式有误" toView:nil];
                return;
            }
        }
        
        if (self.type == 6) {
            if ([HelpManager IsChinese:self.tfEdit.text]) {
                
                [MBProgressHUD showMessage:@"许可证号格式有误" toView:nil];
                return;
            }
        }
        
        if (self.Editblock) {
            self.Editblock(self.tfEdit.text);
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
    
    
    NSString *key = self.mudic.allKeys.firstObject;
    [self.mudic setValue:self.tfEdit.text forKey:key];
    [self editUserDataWith:self.mudic];
  
}


- (void)editUserDataWith:(NSMutableDictionary *)dic {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [APIManager DoUserEditWithParameters:dic success:^(id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        [MBProgressHUD showMessage:@"修改成功" toView:nil];

        if (self.Editblock) {
            self.Editblock(self.tfEdit.text);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
    
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    
    if (self.numLimit==0) {
        return;
    }
    
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.numLimit) {
                textField.text = [toBeString substringToIndex:self.numLimit];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > self.numLimit) {
            textField.text = [toBeString substringToIndex:self.numLimit];
        }  
    }  
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self.tfEdit];
    
    MyLog(@"-PersonEditViewController-释放");

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
