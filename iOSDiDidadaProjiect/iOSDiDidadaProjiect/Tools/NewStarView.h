//
//  NewStarView.h
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewStarView;
@protocol NewStarViewDelegate <NSObject>
@optional
- (void)starRateView:(NewStarView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent;
@end

@interface NewStarView : UIView
@property (nonatomic, assign) CGFloat scorePercent;//得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL hasAnimation;//是否允许动画，默认为NO
@property (nonatomic, assign) BOOL allowIncompleteStar;//评分时是否允许不是整星，默认为NO

@property (nonatomic, weak) id<NewStarViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;
- (NewStarView *)creatViewnumberOfStars:(NSInteger)numberOfStars;

@end
