//
//  HelpViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/22.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "HelpViewController.h"
#import "PersonalDataTableViewCell.h"
#import "PersonDataModel.h"
#import "MyWebViewController.h"

@interface HelpViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HelpViewController

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
}
- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"帮助中心";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"PersonalDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"PersonalDataCell"];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    
    PersonDataModel *model1 = [[PersonDataModel alloc] init];
    model1.className = @"常见问题";
    PersonDataModel *model2 = [[PersonDataModel alloc] init];
    model2.className = @"平台说明";
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    MyWebViewController *myWebVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"MyWebVC"];
    if (indexPath.row == 0) {
        myWebVC.type = @"1";
    }
    
    if (indexPath.row == 1) {
        myWebVC.type = @"2";
    }
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myWebVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalDataCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PersonDataModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-HelpViewController-释放");
    
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
