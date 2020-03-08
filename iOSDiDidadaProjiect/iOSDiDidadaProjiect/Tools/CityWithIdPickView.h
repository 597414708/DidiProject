//
//  CityWithIdPickView.h
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/22.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^confirmBlock)(NSString *proVince,NSString *city,NSString *area);
typedef void(^selectOver)(NSString *proVince, NSString *city, NSString *area, NSString *provinceId, NSString *cityId, NSString *areaId);
typedef void(^cancelBlock)();

@interface CityWithIdPickView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (copy,nonatomic) NSString *province;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *area;
@property (copy,nonatomic) NSString *provinceId;
@property (copy,nonatomic) NSString *cityId;
@property (copy,nonatomic) NSString *areaId;

@property (copy,nonatomic) NSString *address;

@property (nonatomic,assign) BOOL toolshidden;


@property (copy,nonatomic) confirmBlock confirmblock;
@property (copy,nonatomic) cancelBlock cancelblock;
@property (copy,nonatomic) selectOver doneBlock;

- (void)setDefaultAddress;

@end
