//
//  BaojiaShibaiVC.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "InsurerListmodel.h"
@interface BaojiaShibaiVC : UIViewController
@property (nonatomic, strong) UserInfo *inforModel;
@property (nonatomic, strong) InsurerListmodel *senderModel;
@property (nonatomic, strong) NSString *indentId;


@end
