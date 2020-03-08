//
//  SelectedClassView.h
//  IOSHorienMallProject
//
//  Created by 敲代码mac1号 on 2017/1/3.
//  Copyright © 2017年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedClassView : UIView

@property (weak, nonatomic) IBOutlet UILabel *classLabel;

@property (nonatomic , copy) void(^chooseClassBlock)(UILabel *sender);

+ (SelectedClassView *)shareSelectedClassView;

@end
