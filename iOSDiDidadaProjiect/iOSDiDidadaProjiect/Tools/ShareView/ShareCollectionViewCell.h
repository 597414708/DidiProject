//
//  ShareCollectionViewCell.h
//  IM
//
//  Created by 敲代码mac1号 on 16/6/21.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *photoHeight;

@end
