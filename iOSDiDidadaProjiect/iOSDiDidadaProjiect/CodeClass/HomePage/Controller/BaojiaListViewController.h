//
//  BaojiaListViewController.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/30.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface BaojiaListViewController : UIViewController
@property (nonatomic, strong) UserInfo *inforModel;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end
