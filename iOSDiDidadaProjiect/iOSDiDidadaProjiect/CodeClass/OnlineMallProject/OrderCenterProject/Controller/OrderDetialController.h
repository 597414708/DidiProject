//
//  OrderDetialController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCenterModel.h"

@interface OrderDetialController : UIViewController

@property (nonatomic, strong) OrderCenterModel *model;

@property (nonatomic, strong) NSMutableArray *dataSource;


@end
