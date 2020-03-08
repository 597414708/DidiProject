//
//  PersonalDataTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/7.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonDataModel;

@interface PersonalDataTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *classLab;

@property (weak, nonatomic) IBOutlet UIImageView *moreImage;

- (void)showData:(PersonDataModel *)model;
@end
