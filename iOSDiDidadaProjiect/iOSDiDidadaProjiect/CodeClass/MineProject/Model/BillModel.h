//
//  BillModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BillListModel.h"

@interface BillModel : NSObject

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSMutableArray *list;

@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *orderNo;

@end
