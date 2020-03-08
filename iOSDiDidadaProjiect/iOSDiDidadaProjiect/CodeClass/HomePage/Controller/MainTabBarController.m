//
//  MainTabBarController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "MainTabBarController.h"
#import "LoginViewController.h"
@interface MainTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger lastindex;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.lastindex = 0;
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoLog:) name:LogVC object:nil];
    
    for (UITabBarItem *item in self.tabBar.items) {
        item.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [item.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: kCOLOR_HEX(0x464646)} forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName: APPColor} forState:UIControlStateSelected];
        
    }
}

- (void)gotoLog:(NSNotification *)noti {
    
    for (UINavigationController *vc in self.viewControllers) {
        [vc popToRootViewControllerAnimated:YES];
    }
    
    LoginViewController *logVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.selectedIndex = 0;
    [userDef removeObjectForKey:USERID];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSInteger index = self.selectedIndex;
    if (index == 3) {
        NSString *sessionId = [userDef objectForKey: USERID];
        if (sessionId.length == 0) {
            self.selectedIndex = self.lastindex;
            [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
            return;
        }
    }
    self.lastindex = self.selectedIndex;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MyLog(@"-MainTabBarController-释放");

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
