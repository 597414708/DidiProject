//
//  BaoJiajiluSearchVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "BaoJiajiluSearchVC.h"
#import "BaojiaSearchModel.h"
#import "BaojiaSearchListCell.h"
#import "BaodanListModel.h"
#import "BaojiaDetailVC.h"
#import "BaojiaShibaiVC.h"
#import "InsurerListmodel.h"

@interface BaoJiajiluSearchVC () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL isFlag;
@property (nonatomic , assign) NSInteger page;

@property (nonatomic, strong) NSString *senderStr;

@end

@implementation BaoJiajiluSearchVC


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (!_searchBar.isFirstResponder) {
//        [self.searchBar becomeFirstResponder];
//    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.searchBar resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(@available(iOS 11.0, *)){
        self.myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.senderStr = @"";
    [self creatUI];
    [self setBarButtonItem];
    self.myTableView.tableFooterView = [UIView new];
    [self refresh];
}

- (void)creatUI {
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 135;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"BaojiaSearchListCell" bundle:nil] forCellReuseIdentifier:@"BaojiaSearchListCell"];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
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
    NSMutableDictionary *muDic = @{
                                   @"licenseNo":self.senderStr,
                                   @"pageNo":[NSString stringWithFormat:@"%ld", self.page]
                                   }.mutableCopy;
    [APIManager QueryRecordListWithParameters:muDic success:^(id data) {
        if (self.isFlag) {
            [self.dataSource removeAllObjects];
        }
        NSArray *dicArray = data[@"list"];
        for (NSDictionary *dic in dicArray) {
            BaojiaSearchModel *model = [[BaojiaSearchModel alloc] init];
            model = [BaojiaSearchModel mj_objectWithKeyValues:dic];
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

- (void)setBarButtonItem
{
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    
    //默认提示文字
    searchBar.placeholder = @"请输入车牌号";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = kCOLOR_HEX(0x595959);
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:14];
    //输入框背景颜色
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    //拿到取消按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //设置按钮上的文字
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    //设置按钮上文字的颜色
    [cancleBtn setTitleColor:APPColor forState:UIControlStateNormal];
    [titleView addSubview:searchBar];
    titleView.layer.cornerRadius = 15;
    titleView.layer.masksToBounds = YES;
    
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    NSString *str = searchBar.text;
    if (![HelpManager checkCarNumber:str]) {
        [MBProgressHUD showMessage:@"请输入正确车牌号" toView:nil];
        return;
    } else {
        self.senderStr = str;
        [self.myTableView.mj_header beginRefreshing];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *inputStr = searchText;
    //    [self.results removeAllObjects];
    //    for (ElderModel *model in self.dataArray) {
    //        if ([model.name.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
    //            [self.results addObject:model];
    //        }
    //    }
    //    [self.tableView reloadData];
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BaojiaSearchModel *model = self.dataSource[indexPath.row];

    if ([model.quoteStatus isEqualToString:@"1"]) {
        
        BaojiaDetailVC *billVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaDetailVC"];
        BaodanListModel *baodanmodel = [[BaodanListModel alloc] init];
        baodanmodel.info4 = model.id;
        billVC.baodanmodel = baodanmodel;
        billVC.type = 2;
        
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:billVC animated:YES];
    } else {
        
        BaojiaShibaiVC  *senderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BaojiaShibaiVC"];        
        senderVC.indentId = model.id;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:senderVC animated:YES];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaojiaSearchListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BaojiaSearchListCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BaojiaSearchModel *model = self.dataSource[indexPath.row];
    [cell showData:model];
    return cell;
}


- (void)dealloc {
    MyLog(@"-BaoJiajiluSearchVC-释放");
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
