//
//  FindViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "FindViewController.h"

#import "BBSViewController.h"

#import "NewsViewController.h"

#import "PushViewController.h"

@interface FindViewController () <UIScrollViewDelegate> {
    
    UILabel *firstLab;
    UILabel *secondLab;
    BBSViewController *sqVC;
}


@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation FindViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    UIImage *rightImage = [[UIImage imageNamed:@"icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationController.navigationBar setBackIndicatorImage:rightImage];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:rightImage];
    self.navigationController.navigationBar.tintColor = APPColor;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    UIImage *rightImageS = [[UIImage imageNamed:@"icon_issue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImageS style:UIBarButtonItemStylePlain target:self action:@selector(putAction)];

    self.myScrollView.delegate = self;

    [self creatBtn:nil WithLab:firstLab];
    
    [self.view layoutIfNeeded];
    
    self.myScrollView.delegate = self;
   sqVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"BBSVC"];
    [self.firstView addSubview:sqVC.view];
    [self addChildViewController:sqVC] ;
    
    NewsViewController *likeVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"NewsVC"];
    [self.twoView addSubview:likeVC.view];
    [self addChildViewController:likeVC] ;

}

- (void)putAction {
    
    NSString *sessionId = [userDef objectForKey: USERID];
    if (sessionId.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        return;
    }
    PushViewController *pushVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"push"];
    
    [pushVC setMyBlock:^{
        [sqVC refresh];
    }];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)creatUI {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TheW - 150, 40)];
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [firstBtn setTitle:@"汽车论坛" forState:UIControlStateNormal];
    [firstBtn setTitleColor:APPblackColor forState:UIControlStateNormal];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    firstBtn.frame = CGRectMake(0, 0, (TheW - 150) / 2, 38);
    firstLab  = [[UILabel alloc] initWithFrame:CGRectMake(0, 38, (TheW - 150) / 2, 2)];
    firstLab.backgroundColor = APPblackColor;
    [firstBtn addTarget:self action:@selector(squareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake((TheW - 150) / 2, 0, (TheW - 150) / 2, 38);
    [secondBtn setTitle:@"新闻资讯" forState:UIControlStateNormal];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//论坛
- (void)squareAction:(UIButton *)sender {
    [self creatBtn:sender WithLab:firstLab];
    self.myScrollView.contentOffset = CGPointZero;

}

//资讯
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

- (void)dealloc
{
    MyLog(@"-FindViewController-释放");
    
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
