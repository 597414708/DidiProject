//
//  UserPushDetailVC.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/15.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "UserPushDetailVC.h"

#import "ArticleContentCell.h"

#import "ArticleImageCell.h"

@interface UserPushDetailVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTabView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation UserPushDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.title;
    [self creatUI];
    [self creatData];
    
    // Do any additional setup after loading the view.
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = self.model.title;
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
 
    self.imageArray = [self.model.banner componentsSeparatedByString:@","];

    [self.myTabView registerNib:[UINib nibWithNibName:@"ArticleContentCell" bundle:nil] forCellReuseIdentifier:@"ArticleContentCell"];
  
    [self.myTabView registerNib:[UINib nibWithNibName:@"ArticleImageCell" bundle:nil] forCellReuseIdentifier:@"ArticleImageCell"];
    self.myTabView.estimatedRowHeight = 44.0f;
    // 告诉系统, 高度自己计算
    self.myTabView.rowHeight = UITableViewAutomaticDimension;
    
    self.myTabView.delegate = self;
    self.myTabView.dataSource = self;
    self.myTabView.tableFooterView = [UIView new];
    self.nameLab.text = self.model.createName;
    self.timelab.text = self.model.createDate;
    
    self.headImage.layer.cornerRadius = 10;
    self.headImage.layer.masksToBounds = YES;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.model.createHead] placeholderImage:placeHoder];
    
    self.titleLab.text = self.model.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatData {
    NSMutableDictionary *dic = @{@"id":self.model.id}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager GetArticleDetailWithParameters:dic success:^(id data) {
        NSDictionary *dic = data;
        self.model = [ArticleListModel mj_objectWithKeyValues:dic];
        [self.myTabView reloadData];
    } failure:^(NSError *error) {

    }];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTabView beginUpdates];

    CGRect headerFrame = self.myTabView.tableHeaderView.frame;
    headerFrame.size.height = (TheW / 5.0) + 5;
    //修改tableHeaderView的frame
    self.myTabView.tableHeaderView.frame = headerFrame;
    [self.myTabView endUpdates];

}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ArticleContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleContentCell" forIndexPath:indexPath];
        cell.contentLab.text = self.model.content;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        ArticleImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell.contentimage sd_setImageWithURL:[NSURL URLWithString: self.imageArray[indexPath.row - 1]] placeholderImage: placeHoder];
        return cell;
    }
}

- (void)dealloc
{
    MyLog(@"-UserPushDetailVC-释放");
    
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
