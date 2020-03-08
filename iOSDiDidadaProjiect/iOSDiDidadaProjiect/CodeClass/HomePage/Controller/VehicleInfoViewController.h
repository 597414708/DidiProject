//
//  VehicleInfoViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInforModel.h"

@interface VehicleInfoViewController : UIViewController

@property (nonatomic, strong) CarInforModel *model;

@property (nonatomic, strong) NSString *arrea;
@property (nonatomic, strong) NSString *numCode;

@property (nonatomic, assign) BOOL type;

@end
