//
//  PolicyListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "PolicyListViewController.h"
#import "PolicyListCell.h"
#import "BaodanListModel.h"
#import "BaojiaDetailVC.h"

@interface PolicyListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UILabel *thirdLab;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PolicyListViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.type = @"";
    [self creatBtn:nil WithLab:self.firstLab];
    [self creatUI];
    [self creatDataWith:self.type];
    
}


- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"我的保单";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 80;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"PolicyListCell" bundle:nil] forCellReuseIdentifier:@"PolicyListCell"];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);

}


- (void)creatDataWith:(NSString *)type {
    NSDictionary *DIC = @{@"status":type};
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager BaodanListWithParameters:DIC.mutableCopy success:^(id data) {
        self.dataSource = [NSMutableArray array];
        NSArray *dicArray = data;
        self.dataSource = [BaodanListModel mj_objectArrayWithKeyValuesArray:dicArray];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


- (IBAction)zhifuAction:(UIButton *)sender {
    NSArray *arr = @[self.firstLab, self.secondLab, self.thirdLab];
    
    NSInteger index = sender.tag - 100;
    
    [self creatBtn:sender WithLab:arr[index]];
    if (index == 0) {
        self.type = @"";
    } else if (index == 1) {
        self.type = @"1";
    } else {
        self.type = @"3";
    }
    [self creatDataWith:self.type];

}



- (void)creatBtn:(UIButton *)sender WithLab:(UILabel *)labsender {
    
    self.firstLab.backgroundColor = [UIColor clearColor];
    self.secondLab.backgroundColor = [UIColor clearColor];
    self.thirdLab.backgroundColor = [UIColor clearColor];
    labsender.backgroundColor = Color(51, 51, 51);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaodanListModel *model = self.dataSource[indexPath.row];
   
    BaojiaDetailVC *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaDetailVC"];
    billVC.baodanmodel = model;
    billVC.type = 1;

    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:billVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PolicyListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PolicyListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaodanListModel *model = self.dataSource[indexPath.row];
    [cell showDataDD:model];
    return cell;
}



- (void)dealloc {
    MyLog(@"-PolicyListViewController-释放");
    
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
