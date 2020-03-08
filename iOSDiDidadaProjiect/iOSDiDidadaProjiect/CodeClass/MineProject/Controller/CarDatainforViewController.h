//
//  CarDatainforViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInforModel.h"
@interface CarDatainforViewController : UIViewController

@property (nonatomic, copy) NSString *titleS;

@property (nonatomic, copy) NSString *btntitleS;

@property (nonatomic, strong) CarInforModel *model;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *numb;

@property (nonatomic, strong) NSString *engNo;
@property (nonatomic, strong) NSString *carVin;

@property (nonatomic, copy) void (^myBlock)();

@end
