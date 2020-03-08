//
//  AgentCenterVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "AgentCenterVC.h"
#import "AgentListTableViewCell.h"
#import "AgentModel.h"
#import "QrcodeView.h"

@interface AgentCenterVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *agentNameLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@property (weak, nonatomic) IBOutlet UILabel *agentCount;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *userDataSource;

@property (nonatomic, strong) AgentModel *agentModel;

@property (weak, nonatomic) IBOutlet UIButton *qrBtn;
@property (weak, nonatomic) IBOutlet UIImageView *moreBtn;

@end

@implementation AgentCenterVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)userDataSource {
    if (!_userDataSource) {
        self.userDataSource = [NSMutableArray array];
    }
    return _userDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData];
    if (self.url) {
        self.qrBtn.hidden = NO;
    } else {
        self.qrBtn.hidden = YES;
    }
    self.moreBtn.hidden = self.qrBtn.hidden;
}

- (void)creatData {
  
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    NSMutableDictionary *dic = @{@"mobile":self.mobile}.mutableCopy;
    [APIManager AgentInfoWithParameters:dic success:^(id data) {
        NSDictionary *agentDic = data[@"info"];
        self.agentModel = [[AgentModel alloc] init];
        self.agentModel = [AgentModel mj_objectWithKeyValues:agentDic];
        NSArray *agentsArray = data[@"agents"];
        NSArray *usersArray = data[@"users"];
        self.dataSource = [AgentModel mj_objectArrayWithKeyValuesArray:agentsArray];
        self.userDataSource = [AgentModel mj_objectArrayWithKeyValuesArray:usersArray];
        [self upDataUI];
        [self.myTableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)upDataUI {
    self.nameLab.text = self.agentModel.name;
    self.agentNameLab.text =[NSString stringWithFormat:@"(%@)", self.agentModel.levelName];
    self.countLab.text = [NSString stringWithFormat:@"共销售%@笔,合计", self.agentModel.number];
    self.agentCount.text = [NSString stringWithFormat:@"¥%@", self.agentModel.totalMoney];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"代理中心";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 70;
    self.myTableView.backgroundColor = kCOLOR_HEX(0XEEEEEE);

    [self.myTableView registerNib:[UINib nibWithNibName:@"AgentListTableViewCell" bundle:nil] forCellReuseIdentifier:@"AgentListTableViewCell"];
}

- (IBAction)xiaoshouAction:(UIButton *)sender {
    QrcodeView *view = [QrcodeView shareQrcodeViewWithUrl:self.url];
    __weak typeof(view) weakView = view;
    [view setCancelBlock:^{
        [weakView removeFromSuperview];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
}

- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = 205- 40;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataSource.count;
    } else {
        return self.userDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AgentListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AgentModel *model = [[AgentModel alloc] init];
    if (indexPath.section == 0) {
        model = self.dataSource[indexPath.row];
    } else if (indexPath.section == 1){
        model = self.userDataSource[indexPath.row];
    }
    if (indexPath.section == 0) {
        cell.moreImage.hidden = NO;
    } else {
        cell.moreImage.hidden = YES;
    }
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        AgentModel *model = self.dataSource[indexPath.row];
        AgentCenterVC *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"AgentCenterVC"];
        billVC.mobile = model.mobile;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
        
    }
    
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TheW, 40)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
    view.backgroundColor = kCOLOR_HEX(0XEEEEEE);
    lab.textColor = kCOLOR_HEX(0x666666);
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    
    if (section == 1) {
        lab.text = @"直推用户";

        if (self.userDataSource.count == 0) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        return view;
    } else {
        lab.text = @"代理列表";
        if (self.dataSource.count == 0) {
            view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        }
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (self.dataSource.count == 0) {
            return 0;
        }
        return 40;
    } else {
        if (self.userDataSource.count == 0) {
            return 0;
        }
        return 40;
    }
}

- (void)dealloc {
    MyLog(@"-XiaoShowVC-释放");
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
