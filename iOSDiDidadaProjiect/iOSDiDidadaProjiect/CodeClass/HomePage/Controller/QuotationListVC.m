//
//  QuotationListVC.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "QuotationListVC.h"
#import "QuotationListCell.h"
#import "InsurerListmodel.h"

#import "InsuranceOrderDetailVC.h"
#import "ZYInputAlertFieldView.h"

#import "UITextField+DatePicker.h"
#import "BaojiaListViewController.h"

@interface QuotationListVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    ZYInputAlertFieldView *alertView;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation QuotationListVC

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

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"选择保险公司";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 80;
    [self.myTableView registerNib:[UINib nibWithNibName:@"QuotationListCell" bundle:nil] forCellReuseIdentifier:@"QuotationCell"];
    
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
}

- (void)creatData {
    NSMutableDictionary *dicMu = @{@"cityCode":HelpPramodel.postmodel.cityCode}.mutableCopy;
    
    [APIManager BaoxianInsurerListWithParameters:dicMu success:^(id data) {
        NSArray *array = data;
        self.dataSource = [InsurerListmodel mj_objectArrayWithKeyValuesArray:array];
        for (InsurerListmodel *model in self.dataSource) {
            model.select = @"0";
            model.selectII = @"0";
        }
        [self.myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)finishAction:(UIButton *)sender {
    NSInteger sum = 0;
    NSInteger sumbit = 0;

    NSMutableArray *selectArray = [NSMutableArray array];
    for (InsurerListmodel *model in self.dataSource) {
        model.statusMessage = nil;
        if ([model.select isEqualToString:@"1"]) {
            sum += model.code.integerValue;
            [selectArray addObject:model];
        }
        if ([model.selectII isEqualToString:@"1"]) {
            sumbit += model.code.integerValue;
        }
    }
    if (sum == 0) {
        [MBProgressHUD showMessage:@"请选择报价公司" toView:nil];
        return;
    }
    
    HelpPramodel.postmodel.quoteGroup = [NSString stringWithFormat:@"%ld",sum];
    HelpPramodel.postmodel.submitGroup = [NSString stringWithFormat:@"%ld",sumbit];
    
    NSMutableDictionary *dic = [HelpPramodel.postmodel mj_keyValues];

    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    
    [APIManager BaoxianPostPriceWithParameters:dic success:^(id data) {
        
        BaojiaListViewController  *QuotationVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaListViewController"];
        QuotationVC.inforModel = self.inforModel;
        QuotationVC.dataSource = selectArray;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:QuotationVC animated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuotationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    InsurerListmodel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    WS(weakSelf);
    [cell setMyBlock:^(UIButton *sender) {
        QuotationListCell *cellList = (QuotationListCell *)sender.superview.superview.superview;
        NSIndexPath *index = [weakSelf.myTableView indexPathForCell:cellList];
        InsurerListmodel *model = weakSelf.dataSource[index.row];
        if (sender.tag  == 100) {
            if ([model.select isEqualToString:@"0"]) {
                model.select = @"1";
            } else {
                model.select = @"0";
                model.selectII = @"0";
            }
        } else if (sender.tag == 101) {
            if ([model.selectII isEqualToString:@"0"]) {
                model.selectII = @"1";
                model.select = @"1";
            } else {
                model.selectII = @"0";
            }
        }
        
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];

    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == alertView.inputTextView) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        textField.text = [formatter stringFromDate:[UITextField sharedDatePicker].date];
    }
    
    if (textField == alertView.secondField) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        textField.text = [formatter stringFromDate:[UITextField sharedDatePicker].date];
    }
}

- (void)dealloc
{
    MyLog(@"-QuotationListVC-释放");
    
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
