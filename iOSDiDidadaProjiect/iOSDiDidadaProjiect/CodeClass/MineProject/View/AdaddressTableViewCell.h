//
//  AdaddressTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/9.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface AdaddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;

@property (weak, nonatomic) IBOutlet UITextField *contentTf;

- (void)showData:(AddressModel *)model;
@end
