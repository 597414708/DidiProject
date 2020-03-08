//
//  PayTypeModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/1.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayTypeModel : NSObject

@property (nonatomic, strong) NSString *headImage;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, assign) BOOL select;

@end
