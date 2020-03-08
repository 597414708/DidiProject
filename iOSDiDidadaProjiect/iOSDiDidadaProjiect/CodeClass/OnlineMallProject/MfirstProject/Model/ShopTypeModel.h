//
//  ShopTypeModel.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/20.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopTypeModel : NSObject

///分类名称
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

///分类图片
@property (nonatomic, copy) NSString *typeImg;

///分类id
@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *select;


@end
