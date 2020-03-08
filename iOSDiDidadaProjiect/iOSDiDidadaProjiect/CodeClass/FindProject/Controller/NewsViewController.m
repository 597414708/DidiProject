//
//  NewsViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "NewsViewController.h"

#import "NewsTableViewCell.h"
#import "ArticleListModel.h"

#import "NewsDetailViewController.h"

#import "VideoDetailViewController.h"

@interface NewsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;


@end

@implementation NewsViewController


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
    [self refresh];
}

- (void)refresh {
    self.page = 1;
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
    self.myTableView.mj_header = header;
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(creatData)];
    self.myTableView.mj_footer = footer;
}

- (void)creatData {
    
    NSMutableDictionary *muDic = @{@"type":@"0",
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]}.mutableCopy;
    [APIManager GetArticleWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            ArticleListModel *model = [[ArticleListModel alloc] init];
            model = [ArticleListModel mj_objectWithKeyValues:dic];
            [self.dataSource addObject:model];
        }
        self.page += 1;
        self.isFlag = NO;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)creatUI {
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = (TheW * 275.0 / 375) + 45 + 75 + 2 + 5;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    self.myTableView.tableFooterView = [UIView new];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showData:self.dataSource[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleListModel *model = self.dataSource[indexPath.row];
    if ([model.video hasPrefix:@"http://"]) {
        VideoDetailViewController *videoDetailVC =[kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"VideoDetailVC"];
        videoDetailVC.model = model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoDetailVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    } else {
        NewsDetailViewController *newsDetailVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"NewsDetailVC"];
        newsDetailVC.model = model;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newsDetailVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
   
}

- (void)dealloc
{
    MyLog(@"-NewsViewController-释放");
    
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
