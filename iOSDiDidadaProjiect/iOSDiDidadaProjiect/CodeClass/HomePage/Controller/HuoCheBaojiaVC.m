//
//  HuoCheBaojiaVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "HuoCheBaojiaVC.h"
#import "HuoCheBaojiaCell.h"
@interface HuoCheBaojiaVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *topbgView;

@end

@implementation HuoCheBaojiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topbgView.layer.cornerRadius = 4;
    self.topbgView.layer.masksToBounds = YES;
    [self creatUI];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"车险报价";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 76;
    [self.myTableView registerNib:[UINib nibWithNibName:@"HuoCheBaojiaCell" bundle:nil] forCellReuseIdentifier:@"HuoCheBaojiaCell"];
}

- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = (TheW - 20) / 355.0 * 180 + 20;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuoCheBaojiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HuoCheBaojiaCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    return cell;
}
- (void)dealloc
{
    MyLog(@"-HuoCheBaojiaVC-释放");
    
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
