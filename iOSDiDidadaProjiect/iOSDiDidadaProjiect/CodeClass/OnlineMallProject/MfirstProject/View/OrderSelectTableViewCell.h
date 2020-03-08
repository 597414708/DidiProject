//
//  OrderSelectTableViewCell.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/30.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSelectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

- (void)showData:(NSString *)str;
@end
