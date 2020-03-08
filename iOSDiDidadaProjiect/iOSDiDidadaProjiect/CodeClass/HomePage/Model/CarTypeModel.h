//
//  CarTypeModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarTypeModel : NSObject

@property (nonatomic, copy) NSString *select;
@property (nonatomic, copy) NSString *content;

///新车购置价
@property (nonatomic, copy) NSString *purchasePrice;

///该车型支持的保险公司枚举之和
@property (nonatomic, copy) NSString *source;

///支持的保险公司
@property (nonatomic, copy) NSString *sourceName;

///动力别名
@property (nonatomic, copy) NSString *vehicleAlias;

///排气量
@property (nonatomic, copy) NSString *vehicleExhaust;

///品牌型号
@property (nonatomic, copy) NSString *vehicleName;

///精友编码
@property (nonatomic, copy) NSString *vehicleNo;

///座位数
@property (nonatomic, copy) NSString *vehicleSeat;

///购置年款
@property (nonatomic, copy) NSString *vehicleYear;

@end
