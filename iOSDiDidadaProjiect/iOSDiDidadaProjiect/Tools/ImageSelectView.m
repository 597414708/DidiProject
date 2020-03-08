//
//  ImageSelectView.m
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/23.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ImageSelectView.h"

@implementation ImageSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelSelect)];
        [self addGestureRecognizer:tapGesture];
        
        
        self.mainView = [[UIView alloc]init];
        self.mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.mainView];
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(200);
            make.left.right.equalTo(self).offset(0);
            make.height.equalTo(@200);
        }];
        
        
        UIButton *btnCamera = [[UIButton alloc]init];
        [btnCamera setImage:[UIImage imageNamed:@"hdbl_pz"] forState:UIControlStateNormal];
        [btnCamera addTarget:self action:@selector(btnCameraClick) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btnCamera];
        [btnCamera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@50);
            make.centerX.equalTo(self.mainView).offset(-60);
            make.width.height.equalTo(@70);
        }];
        UILabel *labelCamera = [[UILabel alloc]init];
        labelCamera.font = [UIFont systemFontOfSize:16];
        labelCamera.textColor = [UIColor blackColor];
        labelCamera.textAlignment = NSTextAlignmentCenter;
        labelCamera.text = @"拍照";
        [self.mainView addSubview:labelCamera];
        [labelCamera mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnCamera);
            make.top.equalTo(btnCamera.bottom).offset(20);
            make.height.equalTo(@16);
            make.width.equalTo(@70);
        }];
        
        
        //相册
        UIButton *btnPhotoLibrary = [[UIButton alloc]init];
        [btnPhotoLibrary setImage:[UIImage imageNamed:@"hdbl_xc"] forState:UIControlStateNormal];
        [btnPhotoLibrary addTarget:self action:@selector(btnPhotoLibraryClick) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btnPhotoLibrary];
        [btnPhotoLibrary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnCamera);
            make.centerX.equalTo(self.mainView).offset(+60);
            make.width.height.equalTo(@70);
        }];
        UILabel *labelPhotoLibrary = [[UILabel alloc]init];
        labelPhotoLibrary.font = [UIFont systemFontOfSize:16];
        labelPhotoLibrary.textColor = [UIColor blackColor];
        labelPhotoLibrary.textAlignment = NSTextAlignmentCenter;
        labelPhotoLibrary.text = @"相册";
        [self.mainView addSubview:labelPhotoLibrary];
        [labelPhotoLibrary mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnPhotoLibrary);
            make.top.equalTo(btnPhotoLibrary.bottom).offset(20);
            make.height.equalTo(@16);
            make.width.equalTo(@70);
        }];
        
    }
    
    return self;
}

-(void)cancelSelect
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(200);
        make.left.right.equalTo(self).offset(0);
        make.height.equalTo(@200);
    }];

    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)btnCameraClick
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(200);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.doneBlock) {
            self.doneBlock(YES);
        }
    }];
}
-(void)btnPhotoLibraryClick
{
    [self.mainView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(200);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.doneBlock) {
            self.doneBlock(NO);
        }
    }];
}


@end
