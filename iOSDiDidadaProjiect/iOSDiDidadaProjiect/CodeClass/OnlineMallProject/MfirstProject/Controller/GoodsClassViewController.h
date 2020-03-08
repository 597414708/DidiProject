//
//  GoodsClassViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/2.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopTypeModel.h"
@interface GoodsClassViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (nonatomic, copy) void(^myBlock)(ShopTypeModel *model);

@end
