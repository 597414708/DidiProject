//
//  InsuranceOrderDetailVC.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InsurerListmodel.h"

@interface InsuranceOrderDetailVC : UIViewController

@property (nonatomic, strong) InsurerListmodel *model;

@property (nonatomic, strong) NSMutableDictionary *senderDic;
@end
