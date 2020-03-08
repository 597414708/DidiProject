//
//  UITextField+DatePicker.m
//  TextField
//
//  Created by lanouhn on 16/2/28.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "UITextField+DatePicker.h"

@implementation UITextField (DatePicker)

+ (UIDatePicker *)sharedDatePicker {
    static UIDatePicker *daterPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        daterPicker = [[UIDatePicker alloc] init];
        daterPicker.datePickerMode = UIDatePickerModeDate;
    });
    return daterPicker;
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
    if (self.isFirstResponder) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        self.text = [formatter stringFromDate:sender.date];
    }
}

- (void)setDatePickerInput:(BOOL)datePickerInput {
    if (datePickerInput) {
        self.inputView = [UITextField sharedDatePicker];
        
        [[UITextField sharedDatePicker] addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        self.inputView.backgroundColor = [UIColor whiteColor];
    } else {
        self.inputView = nil;
        [[UITextField sharedDatePicker] removeTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

- (BOOL)datePickerInput {
    return [self.inputView isKindOfClass:[UIDatePicker class]];
}






@end
