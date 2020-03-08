//
//  CardataEditTwoCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/10.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@interface CardataEditTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;

@property (weak, nonatomic) IBOutlet UITextField *contentTf;

- (void)showData:(AddressModel *)model;

@end
