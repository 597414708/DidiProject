//
//  InsuredModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/19.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsuredModel : NSObject

@property (nonatomic, copy) NSString *coverageName;
@property (nonatomic, copy) NSString *coverageCode;
@property (nonatomic, copy) NSString *insuredAmount;

@property (nonatomic, copy) NSString *flag;

@property (nonatomic, assign) NSInteger tagflag;


@property (nonatomic, copy) NSString *select;

@property (nonatomic, copy) NSString *price;


@end
