//
//  BaojiaModel.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaojiaModel : NSObject

@property (nonatomic, strong) NSString *bizTotal;

@property (nonatomic, strong) NSString *taxTotal;

@property (nonatomic, strong) NSString *forceTotal;

@property (nonatomic, strong) NSString *quoteResult;

//报价状态，-1=未报价， 0=报价失败，>0报价成功
@property (nonatomic, strong) NSString *quoteStatus;

@property (nonatomic, strong) NSString *statusMessage;

@property (nonatomic, strong) NSString *submitResult;

@property (nonatomic, strong) NSString *indentId;


@property (nonatomic, strong) NSMutableArray *priceList;



@end

