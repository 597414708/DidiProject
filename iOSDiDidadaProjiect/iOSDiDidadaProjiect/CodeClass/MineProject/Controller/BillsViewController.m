//
//  BillsViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BillsViewController.h"

#import "YichuBillsViewController.h"

#import "WeichuBillsViewController.h"


@interface BillsViewController () <UIScrollViewDelegate>{
    
    UILabel *firstLab;
    UILabel *secondLab;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation BillsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hidesBottomBarWhenPushed = YES;

    [self.view layoutIfNeeded];

    self.myScrollView.delegate = self;

    YichuBillsViewController *ycVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"YichuVC"];
    [self.firstView addSubview:ycVC.view];
    [self addChildViewController:ycVC] ;
    
    WeichuBillsViewController *wcVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"WeichuVC"];
    [self.twoView addSubview:wcVC.view];
    [self addChildViewController:wcVC] ;
    
    [self creatUI];
}

- (void)creatUI {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TheW - 150, 40)];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setTitle:@"已出账单" forState:UIControlStateNormal];
    [firstBtn setTitleColor:APPblackColor forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    firstBtn.frame = CGRectMake(0, 0, (TheW - 150) / 2, 38);
    firstLab  = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, (TheW - 150) / 2, 2)];
    firstLab.backgroundColor = APPblackColor;
    [firstBtn addTarget:self action:@selector(squareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake((TheW - 150) / 2, 0, (TheW - 150) / 2, 38);
    [secondBtn setTitle:@"未出账单" forState:UIControlStateNormal];
    [secondBtn setTitleColor:APPblackColor forState:UIControlStateNormal];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:14];

    secondLab  = [[UILabel alloc] initWithFrame:CGRectMake((TheW - 150) / 2, 38, (TheW - 150) / 2, 2)];
    secondLab.backgroundColor =  [UIColor clearColor];
    [secondBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];

    
    [bgView addSubview:firstBtn];
    [bgView addSubview:secondBtn];
    [bgView addSubview:firstLab];
    [bgView addSubview:secondLab];
    
    self.navigationItem.titleView = bgView;

}


//已出
- (void)squareAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:firstLab];
    self.myScrollView.contentOffset = CGPointZero;
    
}

//未出
- (void)likeAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:secondLab];
    self.myScrollView.contentOffset =  CGPointMake(TheW, 0);
    
}

- (void)creatBtn:(UIButton *)sender WithLab:(UILabel *)labsender {
    
    firstLab.backgroundColor = [UIColor clearColor];
    
    secondLab.backgroundColor = [UIColor clearColor];
    
    labsender.backgroundColor = Color(51, 51, 51);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.myScrollView.contentOffset.x / TheW == 0) {
        
        [self creatBtn:nil WithLab:firstLab];
        
    } else if (self.myScrollView.contentOffset.x / TheW == 1)
        
    {
        [self creatBtn:nil WithLab:secondLab];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    MyLog(@"-BillsViewController-释放");
    
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
