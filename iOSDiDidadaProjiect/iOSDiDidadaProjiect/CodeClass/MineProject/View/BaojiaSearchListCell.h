//
//  BaojiaSearchListCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/17.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaojiaSearchModel;

@interface BaojiaSearchListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UILabel *sourceName;
@property (weak, nonatomic) IBOutlet UILabel *midleLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UILabel *modleName;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;

- (void)showData:(BaojiaSearchModel *)model;

@end
