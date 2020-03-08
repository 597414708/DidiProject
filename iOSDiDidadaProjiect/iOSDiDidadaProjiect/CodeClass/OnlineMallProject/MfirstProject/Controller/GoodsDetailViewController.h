//
//  GoodsDetailViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/3.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

@interface GoodsDetailViewController : UIViewController

@property (nonatomic, strong) GoodsModel *model;

@property (nonatomic, assign) BOOL hide;
@end
