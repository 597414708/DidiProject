//
//  DingdanInforVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "DingdanInforVC.h"
#import "CallcenterViewController.h"
@interface DingdanInforVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *dingdanNum;

@property (weak, nonatomic) IBOutlet UILabel *baodanNum;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation DingdanInforVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headImage.layer.cornerRadius = 40;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderWidth = 1;
    self.headImage.layer.borderColor = kCOLOR_HEX(0xeeeeee).CGColor;
    
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"保单详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.tableFooterView = [UIView new];
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
}


- (IBAction)kefuAction:(UIButton *)sender {
    CallcenterViewController *callVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CallcenterVC"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:callVC animated:YES];
}

- (void)viewDidLayoutSubviews {
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = 482;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    MyLog(@"-DingdanInforVC-释放");
    
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
