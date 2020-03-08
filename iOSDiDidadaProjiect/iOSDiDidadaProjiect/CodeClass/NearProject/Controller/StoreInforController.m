//
//  StoreInforController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StoreInforController.h"
#import "MineListTableViewCell.h"
#import "ListModel.h"
#import "StoreHomeViewController.h"

@interface StoreInforController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *listDataSource;

@end

@implementation StoreInforController

- (NSMutableArray *)listDataSource {
    if (!_listDataSource) {
        self.listDataSource = [NSMutableArray array];
    }
    return _listDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(@available(iOS 11.0, *)){self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatListData];
}


- (void)creatUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 41;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineListCell"];
}

- (void)creatListData {
    
    ListModel *model2 = [[ListModel alloc] init];
    model2.className = self.model.address;
    model2.bgImage = @"icon_address";
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = [NSString stringWithFormat:@"商家电话：%@", self.model.mobile];
    model3.bgImage = @"icon_shoptel";
    
    ListModel *model4 = [[ListModel alloc] init];
    model4.className = [NSString stringWithFormat:@"营业时间： %@ ~ %@", self.model.startTime, self.model.endTime];
    model4.bgImage = @"shijian";
    
    
    ListModel *model5 = [[ListModel alloc] init];
    model5.className = @"商家资质";
    model5.bgImage = @"icon_shopapt";
    
    ListModel *model6 = [[ListModel alloc] init];
    model6.className = @"商家介绍";
    model6.bgImage = @"icon_shoprec";
    
    [self.listDataSource addObject:model2];
    [self.listDataSource addObject:model3];
    [self.listDataSource addObject:model4];
    [self.listDataSource addObject:model5];
    [self.listDataSource addObject:model6];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.moreImage.hidden = YES;
    ListModel *model = self.listDataSource[indexPath.row];
    [cell showListData:model];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-StoreInforController-释放");
    
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
