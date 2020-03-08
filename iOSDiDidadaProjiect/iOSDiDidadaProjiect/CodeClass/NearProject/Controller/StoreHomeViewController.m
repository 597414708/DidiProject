//
//  StoreHomeViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "StoreHomeViewController.h"
#import "HJTabViewControllerPlugin_HeaderScroll.h"
#import "HJTabViewControllerPlugin_TabViewBar.h"
#import "HJDefaultTabViewBar.h"

#import "ServiceProjectController.h"
#import "CarFriendCommentController.h"
#import "StoreInforController.h"
#import "StoreHeadView.h"
#import "AreaModel.h"
#import "ChooseTimeViewController.h"


@interface StoreHomeViewController () <HJTabViewControllerDataSource, HJTabViewControllerDelagate, HJDefaultTabViewBarDelegate> {
    StoreHeadView *myHeadView;
}

@end

@implementation StoreHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabDataSource = self;
    self.tabDelegate = self;
    
    HJDefaultTabViewBar *tabViewBar = [HJDefaultTabViewBar new];
    tabViewBar.delegate = self;
    HJTabViewControllerPlugin_TabViewBar *tabViewBarPlugin = [[HJTabViewControllerPlugin_TabViewBar alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    [self enablePlugin:[HJTabViewControllerPlugin_HeaderScroll new]];
    [self creatUI];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"店铺详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
//    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    searchButton.frame = CGRectMake(0, 0, TheW - 60, 30);
//    searchButton.backgroundColor = kCOLOR_HEX(0xeeeeee);
//    searchButton.layer.cornerRadius = 15;
//    searchButton.layer.masksToBounds = YES;
//    [searchButton setTitle:@"🔍 搜索商品" forState:UIControlStateNormal];
//    [searchButton setTitleColor:APPGrayColor forState:UIControlStateNormal];
//    searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
//    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = searchButton;
}

- (void)searchAction:(UIButton *)sender {
    
}

#pragma mark -
- (NSInteger)numberOfTabForTabViewBar:(HJDefaultTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (id)tabViewBar:(HJDefaultTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"服务项目";
    } else if (index == 1) {
        return @"好友点评";
    } 
    return @"商家信息";
}

- (void)tabViewBar:(HJDefaultTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    [self.view layoutIfNeeded];
    [self scrollToIndex:index animated:YES];
}

#pragma mark -
//
//- (void)tabViewController:(HJTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY {
//    self.navigationController.navigationBar.alpha = contentPercentY;
//}

- (NSInteger)numberOfViewControllerForTabViewController:(HJTabViewController *)tabViewController {
    return 3;
}

- (UIViewController *)tabViewController:(HJTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    
    if (index == 0) {
        ServiceProjectController *vc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"ServiceProjectVC"];
        vc.model = self.model;
        vc.index = index;
        return vc;
    } else if(index == 1) {
        CarFriendCommentController*vc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"CarFriendCommentVC"];
        vc.model = self.model;
        vc.index = index;
        return vc;
    } else {
        StoreInforController *vc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"StoreInforVC"];
        vc.index = index;
        vc.model = self.model;
        return vc;
    }
}

- (UIView *)tabHeaderViewForTabViewController:(HJTabViewController *)tabViewController {
    myHeadView = [StoreHeadView ShareStoreHeadVie];
    [myHeadView.shopImage sd_setImageWithURL:[NSURL URLWithString:self.model.logo] placeholderImage:placeHoder];
    myHeadView.nameLab.text = self.model.name;
    myHeadView.timeLab.text = [NSString stringWithFormat:@"%@ ~ %@", self.model.startTime, self.model.endTime];
    WS(weakSelf);
    [myHeadView setMyBlock:^{
        
        NSString *sessionId = [userDef objectForKey: USERID];
        if (sessionId.length == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
            return;
        }
        ChooseTimeViewController * choosetime = [[ChooseTimeViewController alloc]init];
        choosetime.ChooseTimeConfirmClickBlock = ^(NSTimeInterval selectTimeInterval, NSString *content) {
            
            NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday fromDate:[NSDate dateWithTimeIntervalSince1970:selectTimeInterval]];
            NSString *dateTime = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%02ld",comps.year,comps.month,comps.day,comps.hour,comps.minute,comps.second];
            NSLog(@"%@", dateTime);
          
            NSString *ss = [NSString stringWithFormat:@"%0.lf", selectTimeInterval * 1000];
            NSMutableDictionary *muDic = @{@"content":content,
                                           @"startTime":ss,
                                           @"shopId":weakSelf.model.id
                                           }.mutableCopy;
            
            [APIManager DoOrderAddWithParameters:muDic success:^(id data) {
                NSString *ss = [NSString stringWithFormat:@"%@", data];
                [MBProgressHUD showMessage:ss toView:nil];
                
            } failure:^(NSError *error) {
                
            }];

        };
        
        NSString *startDate = [HelpManager getDate:weakSelf.model.startTime Withfromformat:@"HH:mm:ss" Toformatt:@"HH:mm"];
        choosetime.startTime = startDate;
        
        NSString *endDate = [HelpManager getDate:weakSelf.model.endTime Withfromformat:@"HH:mm:ss" Toformatt:@"HH:mm"];
        choosetime.endTime = endDate;

        weakSelf.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:choosetime animated:YES];
        
    }];

    return myHeadView;
}


- (CGFloat)tabHeaderBottomInsetForTabViewController:(HJTabViewController *)tabViewController {
    
    return HJTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(HJTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
   [[StockCodeFMDB shareStockCodeFMDB] deleteMessageWith:self.model.id];
    MyLog(@"-StoreHomeViewController-释放");

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
