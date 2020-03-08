//
//  ViewController.h
//  MBProgressHUB+Add
//
//  Created by 敲代码mac1号 on 16/6/15.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showMessage:(NSString *)message toView:(UIView *)view delay:(NSTimeInterval)timeInterval;
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;
- (void)showError:(NSString *)error;
- (void)showSuccess:(NSString *)success;

@end
