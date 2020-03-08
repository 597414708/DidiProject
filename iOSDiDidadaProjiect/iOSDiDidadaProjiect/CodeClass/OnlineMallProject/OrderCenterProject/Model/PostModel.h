//
//  PostModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostCompanyModel.h"
#import "PostListModel.h"

@interface PostModel : NSObject

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) PostCompanyModel *company;

@end
