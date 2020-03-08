//
//  CollectionTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/18.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PriceListModel;

@interface CollectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstLab;

@property (weak, nonatomic) IBOutlet UILabel *secondLab;

- (void)showData:(PriceListModel *)model;


@end
