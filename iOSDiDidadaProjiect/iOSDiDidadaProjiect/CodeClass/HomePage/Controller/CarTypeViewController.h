//
//  CarTypeViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "CarTypeModel.h"

@interface CarTypeViewController : UIViewController

@property (nonatomic, strong) UserInfo *inforModel;

@property (nonatomic, copy) void(^myBlock)(CarTypeModel *sender);

@end
