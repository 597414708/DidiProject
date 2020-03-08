//
//  SelectedClassView.m
//  IOSHorienMallProject
//
//  Created by 敲代码mac1号 on 2017/1/3.
//  Copyright © 2017年 敲代码mac1号. All rights reserved.
//

#import "SelectedClassView.h"

@implementation SelectedClassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (SelectedClassView *)shareSelectedClassView {
    SelectedClassView *view = [[[NSBundle mainBundle] loadNibNamed:@"SelectedClassView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor whiteColor];
    view.bounds = CGRectMake(0, 0, TheW, 50);

    return view;
}


- (IBAction)chooseAction:(UIButton *)sender {
    if (self.chooseClassBlock) {
        self.chooseClassBlock(self.classLabel);
    }
    
}

@end
