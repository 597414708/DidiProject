//
//  SelectAddressCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressDataModel;
@interface SelectAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

- (void)showData:(AddressDataModel *)model;

- (void)showPost:(NSString *)model;

@end
