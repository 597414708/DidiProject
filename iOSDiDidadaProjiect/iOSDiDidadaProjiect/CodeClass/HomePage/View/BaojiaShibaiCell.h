//
//  BaojiaShibaiCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/1.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;

@interface BaojiaShibaiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *midLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;

- (void)showData:(ListModel *)model;
@end
