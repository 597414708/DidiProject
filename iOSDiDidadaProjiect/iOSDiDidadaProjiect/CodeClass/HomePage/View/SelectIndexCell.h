//
//  SelectIndexCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/23.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectIndexCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UISegmentedControl *mySeg;
@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (nonatomic, copy) void(^myBlock)(NSInteger sender);

- (void)showData:(NSInteger)index;
@end
