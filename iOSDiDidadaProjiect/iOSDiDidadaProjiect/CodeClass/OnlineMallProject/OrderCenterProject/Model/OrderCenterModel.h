//
//  OrderCenterModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderCenterGoodsModel.h"

@interface OrderCenterModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *orderNo;

@property (nonatomic, strong) NSString *outTradeNo;

@property (nonatomic, strong) NSString *totalMoney;

@property (nonatomic, strong) NSString *payMoney;

@property (nonatomic, strong) NSMutableArray *indentList;

@property (nonatomic, strong) NSString *indentStatus;



@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *country;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *payTime;


@property (nonatomic, strong) NSString *expressNo;
@property (nonatomic, strong) NSString *carriage;

@property (nonatomic, strong) NSString *receiveMobile;

@property (nonatomic, strong) NSString *receiveName;

@property (nonatomic, strong) NSString *needInvoice;

@property (nonatomic, strong) NSString *invoiceName;

@end
