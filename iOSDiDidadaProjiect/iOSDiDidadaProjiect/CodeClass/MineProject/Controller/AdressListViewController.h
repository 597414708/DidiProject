//
//  AdressListViewController.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressDataModel.h"
@interface AdressListViewController : UIViewController

@property (nonatomic, copy) void (^myBlock)(AddressDataModel *model);

@end