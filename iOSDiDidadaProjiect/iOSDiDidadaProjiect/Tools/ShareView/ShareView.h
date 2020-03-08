//
//  ShareView.h
//  IM
//
//  Created by 敲代码mac1号 on 16/6/17.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareCollectionViewCell.h"

@interface ShareView : UIView <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UIView *alphView;
}
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *shareCollectionView;

@property (weak, nonatomic) IBOutlet UIView *alphBackView;

@property (nonatomic , strong) NSArray *shareArray;

@property (nonatomic, copy) void(^QQBlock)();
@property (nonatomic, copy) void(^WeiChatBlock)();
@property (nonatomic, copy) void(^WeiBoBlock)();
@property (nonatomic, copy) void(^FriendBlock)();

+ (ShareView *)shareViewQQShare:(void(^)())QQShareBlock WeiChatShare:(void(^)())WeiChatShareBlock WeiBoShare:(void(^)())WeiBoShareBlock FriendShare:(void(^)())FriendShareBlock;

@end
