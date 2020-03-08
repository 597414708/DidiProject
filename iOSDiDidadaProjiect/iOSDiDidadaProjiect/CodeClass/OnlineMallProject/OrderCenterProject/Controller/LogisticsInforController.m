//
//  LogisticsInforController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/16.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "LogisticsInforController.h"
#import "FirstLogisticsCell.h"
#import "OrderGoodsCell.h"
@interface LogisticsInforController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *orderLab;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation LogisticsInforController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatUI {
    self.orderLab.text = [NSString stringWithFormat:@"订单编号: %@", self.model.orderNo];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"物流详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 76;
    [self.myTableView registerNib:[UINib nibWithNibName:@"FirstLogisticsCell" bundle:nil] forCellReuseIdentifier:@"FirstLogisticsCell"];
    
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"OrderGoodsCell" bundle:nil] forCellReuseIdentifier:@"OrderGoodsCell"];
    
}


- (void) creatData {
    //    NSDictionary *dic = @{@"num":self.model.expressNo};
    //    [APIManager ExpressInfoWithParameters:dic.mutableCopy success:^(id data) {
    //
    //    } failure:^(NSError *error) {
    //
    //    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return self.model.indentList.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        OrderGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        OrderCenterGoodsModel *model = self.model.indentList[indexPath.row];
        [cell showDataCenter:model];
        return cell;
    } else {
        FirstLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FirstLogisticsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSInteger type;
        if (self.dataSource.count  == 1) {
            type = 3;
        } else if (indexPath.row == 0) {
            type = 0;
        } else if (indexPath.row == (self.dataSource.count - 1)) {
            type = 2;
        } else {
            type = 1;
        }
        
        PostListModel *model  = self.dataSource[indexPath.row];
        [cell typeWith:type With:model];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return 0;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TheW, 5)];
        lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
        lab.font = [UIFont systemFontOfSize:13];
        return lab;
    } else {
        return nil;
    }
    
}

- (void)dealloc
{
    MyLog(@"-LogisticsInforController-释放");
    
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
