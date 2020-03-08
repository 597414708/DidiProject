//
//  ChooseCityView.h
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

@interface ChooseCityView : UIView  <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) void(^confirmBlock)(HZLocation *);
@property (nonatomic, copy) void(^cancleBlock)(NSInteger );
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *cityPikeView;
@property (nonatomic, assign)NSInteger sex;

@property (nonatomic , strong) NSArray *provinces;
@property (nonatomic , strong) NSArray *cities;

@property (nonatomic, strong) NSArray *keyArray;
@property (strong, nonatomic) HZLocation *locate;


+ (ChooseCityView *)creatChooseCityViewWithDataSource:(NSMutableArray *)dataSource WithKey:(NSArray *)keyArray;
- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(HZLocation *))confirmBlock;

@end
