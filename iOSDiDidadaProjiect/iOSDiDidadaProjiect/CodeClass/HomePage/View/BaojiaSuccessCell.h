//
//  BaojiaSuccessCell.h
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/8/13.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PriceListModel;

@interface BaojiaSuccessCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *leftLab;
@property (weak, nonatomic) IBOutlet UILabel *rightLab;
@property (weak, nonatomic) IBOutlet UIImageView *downImage;

- (void)showData:(PriceListModel *)model index:(NSIndexPath *)index;


@end
