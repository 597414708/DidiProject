//
//  SelectDateViewController.m
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "SelectDateViewController.h"

@interface SelectDateViewController ()

@property(nonatomic, strong)UIDatePicker *datePicker;
@property(nonatomic,strong)UIView *mainView;
@end

@implementation SelectDateViewController

-(UIDatePicker *)datePicker
{
    if (_datePicker==nil) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _datePicker.userInteractionEnabled = YES;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        _datePicker.locale = locale;
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minuteInterval = 5;
        NSDate* minDate = [NSDate date];
        NSDate* maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:60*60*24*365];
//        _datePicker.minimumDate = minDate;
//        _datePicker.maximumDate = maxDate;
//        [_datePicker setDate:minDate animated:YES];
        [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    }
    return _datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    [self configView];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self.view layoutIfNeeded];
    }];
}

-(void)configView
{
    UIView *mainView = [[UIView alloc]init];
    self.mainView=mainView;
    mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.height.equalTo(@240);
        make.bottom.equalTo(self.view).offset(240);
    }];
    
    [mainView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@40);
        make.left.right.bottom.equalTo(mainView).offset(0);
    }];
    
    //取消按钮
    UIButton *btnCancel = [[UIButton alloc]init];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnCancel addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btnCancel];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView).offset(10);
        make.top.equalTo(mainView).offset(0);
        make.width.height.equalTo(@40);
    }];
    //确定
    UIButton *btnCertain = [[UIButton alloc]init];
    [btnCertain setTitle:@"确定" forState:UIControlStateNormal];
    [btnCertain setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnCertain.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnCertain addTarget:self action:@selector(btnCertainClick) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:btnCertain];
    [btnCertain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(mainView).offset(-10);
        make.top.equalTo(mainView).offset(0);
        make.width.height.equalTo(@40);
    }];
    
}

- (void)setBeginTime:(NSString *)beginTime
{
    _beginTime = beginTime;
    if (beginTime.length > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *beginDate = [dateFormatter dateFromString:self.beginTime];
        self.datePicker.minimumDate = beginDate;
    } else {
        self.datePicker.minimumDate = [NSDate date];
        [self.datePicker setDate:[NSDate date] animated:NO];
    }
}

-(void)dateChanged:(id)sender{
    ;
    NSDate* _date = self.datePicker.date;
    /*添加你自己响应代码*/
}

//取消
-(void)btnCancelClick
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(240);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
    
}
//确定
-(void)btnCertainClick
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self.datePicker.date];
    if (self.beginTime.length > 0) {//
        NSDate *beginDate = [dateFormatter dateFromString:self.beginTime];
        if ([self.datePicker.date timeIntervalSinceDate:beginDate] < 0) {
            [MBProgressHUD showError:@"结束时间不能小于开始时间" toView:self.view];
            return;
        }
    }
    
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(240);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (self.dateSelectBlock) {
            self.dateSelectBlock(strDate);
        }
        [self.view removeFromSuperview ];
    }];
    
    
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
