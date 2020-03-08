//
//  BaojiaDetailVC.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/13.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "InsurerListmodel.h"

#import "BillListModel.h"
#import "BaodanListModel.h"

@interface BaojiaDetailVC : UIViewController

@property (nonatomic, strong) UserInfo *inforModel;
@property (nonatomic, strong) InsurerListmodel *senderModel;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) BillListModel *model;

@property (nonatomic, strong) BaodanListModel *baodanmodel;



@end
