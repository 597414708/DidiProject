//
//  CgoodListViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/26.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CgoodListViewController.h"
#import "CgoodSListTableViewCell.h"

#import "OrderCenterGoodsModel.h"
#import "CommentViewController.h"


@interface CgoodListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation CgoodListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatUI];
}

- (void)creatUI {
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"商品列表";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 91;
    [self.myTableView registerNib:[UINib nibWithNibName:@"CgoodSListTableViewCell" bundle:nil] forCellReuseIdentifier:@"CgoodSListTableViewCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CgoodSListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CgoodSListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderCenterGoodsModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCenterGoodsModel *model = self.dataSource[indexPath.row];

    CommentViewController *VC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CommentVC"];
    VC.model = model;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-CgoodListViewController-释放");
    
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
