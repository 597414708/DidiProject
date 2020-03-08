//
//  BottomView.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/15.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (BottomView *) ShareBottomView {
    BottomView *view = [[[NSBundle mainBundle] loadNibNamed:@"BottomView" owner:nil options:nil] firstObject];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, TheW, 46);
    return view;
}
- (IBAction)finishAction:(UIButton *)sender {
    if (self.myBlock) {
        self.myBlock();
    }
    
}

@end
