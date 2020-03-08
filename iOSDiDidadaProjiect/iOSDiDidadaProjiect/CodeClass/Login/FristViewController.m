//
//  FristViewController.m
//  OurProjectA
//
//  Created by lanouhn on 16/4/8.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "FristViewController.h"
#import "MainTabBarController.h"
#import "AppDelegate.h"
#define Count 3

#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height
@interface FristViewController ()

@property (nonatomic , strong) NSArray *imageArray;

@end

@implementation FristViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArray = @[@"plus1",@"plus2",@"plus3"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, TheW, TheH)];
    scrollView.contentSize = CGSizeMake(TheW * self.imageArray.count, TheH);
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(TheW * i, 0, TheW, TheH)];
        NSString *name = self.imageArray[i];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
    }
    
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(TheW * (self.imageArray.count - 1) + (TheW - 125) / 2,  TheH - 120,  125 , 80)];

    [button addTarget:self action:@selector(startlater:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [scrollView addSubview:button];
}

- (void)startlater:(UIButton *)button
{
    MainTabBarController *rootController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainTabBarVC"];
    [self presentViewController:rootController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-FristViewController-释放");
    
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
