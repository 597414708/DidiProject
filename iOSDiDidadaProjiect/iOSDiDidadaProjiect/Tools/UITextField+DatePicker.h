//
//  UITextField+DatePicker.h
//  TextField
//
//  Created by lanouhn on 16/2/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (DatePicker)

+ (UIDatePicker *)sharedDatePicker;

- (void)datePickerValueChanged:(UIDatePicker *)sender;

- (void)setDatePickerInput:(BOOL)datePickerInput;

- (BOOL)datePickerInput;

@end
