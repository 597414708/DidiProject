//
//  CallcenterViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CallcenterViewController.h"
#import "UITextView+Placeholder.h"

@interface CallcenterViewController ()

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *numLab;

@end

@implementation CallcenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTextView.placeholder = @"请输入你的建议.....";
    [self creatUI];
    [self creatData];
}
- (void)creatData {
    [APIManager GetAppVersionWithParameters:nil success:^(id data) {
        NSDictionary *dic = data;
        self.numLab.text = [NSString stringWithFormat:@"%@",  [dic objectForKey:@"connectMobile"]];
    } failure:^(NSError *error) {
        
    }];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"客服中心";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

}

- (IBAction)callAction:(UIButton *)sender {
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@", self.numLab.text];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (IBAction)finishAction:(UIButton *)sender {
    if (self.myTextView.text.length == 0) {
        [MBProgressHUD showMessage:@"请填写反馈内容" toView:nil];

        return;
    }
    
    NSMutableDictionary *dic = @{@"content":self.myTextView.text}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager KefuAddWithParameters:dic success:^(id data) {
        [MBProgressHUD showMessage:@"已反馈" toView:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-CallcenterViewController-释放");
    
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
