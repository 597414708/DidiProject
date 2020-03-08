//
//  CommentViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/6.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderCenterModel.h"
#import "OrderModel.h"

@interface CommentViewController : UIViewController
@property (nonatomic, strong) OrderCenterGoodsModel *model;
@property (nonatomic, strong) OrderModel *orderMd;
@property (nonatomic, copy) void(^myBlock)();
@end
