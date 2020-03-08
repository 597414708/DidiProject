//
//  InsuranceOrderModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuranceOrderModel : NSObject


@property (nonatomic, strong) NSString *biBeginDate;

@property (nonatomic, strong) NSString *ciBeginDate;

@property (nonatomic, strong) NSMutableArray *coverageList;

@property (nonatomic, strong) NSString *bizID;

@property (nonatomic, strong) NSString *channelCode;

@property (nonatomic, strong) NSString *thpBizID;

@property (nonatomic, strong) NSString *carshipTax;

@property (nonatomic, strong) NSString *biPremium;

@property (nonatomic, strong) NSString *ciPremium;


@end
