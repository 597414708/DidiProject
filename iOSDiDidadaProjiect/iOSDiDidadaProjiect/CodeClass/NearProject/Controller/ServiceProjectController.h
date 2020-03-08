//
//  ServiceProjectController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/14.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"

@interface ServiceProjectController : UITableViewController
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) ShopModel *model;

@end
