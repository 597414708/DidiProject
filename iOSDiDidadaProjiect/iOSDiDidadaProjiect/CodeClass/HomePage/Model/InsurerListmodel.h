//
//  InsurerListmodel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsurerListmodel : NSObject

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *code;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *logo;


@property (nonatomic, strong) NSString *biPremium;

@property (nonatomic, strong) NSString *carshipTax;

@property (nonatomic, strong) NSString *ciPremium;

@property (nonatomic, strong) NSString *refId;


@property (nonatomic, strong) NSString *select;

@property (nonatomic, strong) NSString *selectII;



@property (nonatomic, strong) NSString *bizTotal;

@property (nonatomic, strong) NSString *taxTotal;

@property (nonatomic, strong) NSString *forceTotal;

@property (nonatomic, strong) NSString *quoteResult;

//报价状态，-1=未报价， 0=报价失败，>0报价成功
@property (nonatomic, strong) NSString *quoteStatus;

@property (nonatomic, strong) NSString *statusMessage;

@property (nonatomic, strong) NSString *submitResult;

@property (nonatomic, strong) NSMutableArray *priceList;

@property (nonatomic, strong) NSString *indentId;


@end
