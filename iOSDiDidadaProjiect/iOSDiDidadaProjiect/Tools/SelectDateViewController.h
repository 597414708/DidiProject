//
//  SelectDateViewController.h
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDateViewController : UIViewController

@property (nonatomic,copy)void(^dateSelectBlock)(NSString *str);
@property (nonatomic, strong) NSString *strDate;
@property (nonatomic, strong) NSString *beginTime;

@end
