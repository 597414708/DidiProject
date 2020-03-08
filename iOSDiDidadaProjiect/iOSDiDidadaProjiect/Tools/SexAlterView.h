//
//  SexAlterView.h
//  GxHappyApp
//
//  Created by 敲代码mac2号 on 16/7/13.
//  Copyright © 2016年 chengleiGG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZLocation;
@interface SexAlterView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, copy) void(^confirmBlock)(HZLocation *);
@property (nonatomic, copy) void(^cancleBlock)(NSInteger );
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *sexPikeView;

@property (nonatomic, strong) HZLocation *location;

@property (nonatomic , strong) NSArray *locationArray;

@property (nonatomic , strong) NSArray *keyArray;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+ (SexAlterView *)creatSexAlterViewWith:(NSMutableArray *)dataSource WithKey:(NSArray *)keyArray;
- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(HZLocation *))confirmBlock;
@end
