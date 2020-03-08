//
//  CarFriendCommentController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarFriendCommentController.h"
#import "StoreCommentCell.h"
#import "CommentModel.h"
@interface CarFriendCommentController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation CarFriendCommentController

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
    if(@available(iOS 11.0, *)){self.tableView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self creatVisitorsRefresh];
}


- (void)creatUI {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 150;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreCommentCell" bundle:nil] forCellReuseIdentifier:@"StoreCommentCell"];
    
    self.tableView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)creatVisitorsRefresh {
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新时松手后就会走这个block内部
        weakSelf.isFlag = YES;
        weakSelf.page = 1;
        [weakSelf creatData];
    }];
    
    [header beginRefreshing];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.tableView.mj_footer = footer;
}


- (void)creatData {
    NSMutableDictionary *muDic = @{@"shopId":self.model.id,
                                   @"type":@"2",
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:nil animated:YES];

    [APIManager GetGetEvolutionListWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            CommentModel *model = [[CommentModel alloc] init];
            model = [CommentModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        self.page += 1;
        self.isFlag = NO;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreCommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommentModel *model = self.dataSource[indexPath.row];
    [cell showDataWith:model];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    MyLog(@"-CarFriendCommentController-释放");
    
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
