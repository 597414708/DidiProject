//
//  InsuranceDetailModel.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/26.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveQuote.h"
#import "UserInfo.h"

@interface InsuranceDetailModel : NSObject

@property (nonatomic, strong) SaveQuote *saveQuote;
@property (nonatomic, strong) UserInfo *userInfo;

@end
