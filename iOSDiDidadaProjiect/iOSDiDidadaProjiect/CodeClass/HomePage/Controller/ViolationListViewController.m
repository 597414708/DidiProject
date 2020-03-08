//
//  ViolationListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ViolationListViewController.h"
#import "CarWeizhangListCell.h"
#import "ViolationDetailViewController.h"

@interface ViolationListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@end

@implementation ViolationListViewController

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
    titleLab.text = self.titleStr;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 60;
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    [self.myTableView registerNib:[UINib nibWithNibName:@"CarWeizhangListCell" bundle:nil] forCellReuseIdentifier:@"CarWeizhangListCell"];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CarWeizhangListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarWeizhangListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeizhangModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeizhangModel *model = self.dataSource[indexPath.row];
    ViolationDetailViewController *detailVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"ViolationDetailVC"];
    detailVC.titleStr = self.titleStr;
    detailVC.model = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-ViolationListViewController-释放");
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
