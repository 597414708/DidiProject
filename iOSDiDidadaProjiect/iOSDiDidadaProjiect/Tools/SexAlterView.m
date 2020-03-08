//
//  SexAlterView.m
//  GxHappyApp
//
//  Created by 敲代码mac2号 on 16/7/13.
//  Copyright © 2016年 chengleiGG. All rights reserved.
//

#import "SexAlterView.h"
#import "HZLocation.h"

#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height
@implementation SexAlterView


- (HZLocation *)location {
    if (!_location) {
        self.location = [[HZLocation alloc] init];
    }
    return _location;
}

//@[@"provinceName", @"provinceCode"]
+ (SexAlterView *)creatSexAlterViewWith:(NSMutableArray *)dataSource WithKey:(NSArray *)keyArray {
    SexAlterView *sexAV = [[[NSBundle mainBundle] loadNibNamed:@"SexAlterView" owner:nil options:nil] firstObject];
    sexAV.backgroundColor = [UIColor clearColor];
    sexAV.frame = CGRectMake(0, 0, TheW, TheH);

    sexAV.keyArray = keyArray;
    sexAV.locationArray = dataSource.mutableCopy;
    sexAV.sexPikeView.delegate = sexAV;
    sexAV.sexPikeView.dataSource = sexAV;
    sexAV.location.state = [[sexAV.locationArray objectAtIndex:0] objectForKey:keyArray[0]];
    
    if (keyArray.count == 2) {
        sexAV.location.city_code = [[sexAV.locationArray objectAtIndex:0] objectForKey:keyArray[1]];
        
    }
    
    

    return sexAV;
    
}

- (NSArray *)locationArray {
    if (!_locationArray) {
        self.locationArray = [NSArray array];
    }
    return _locationArray;
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.location);
        [self removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self removeFromSuperview];
}


- (void)showCancle:(void(^)())cancleBlock confirm:(void (^)(HZLocation *))confirmBlock {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.cancleBlock = cancleBlock;
    self.confirmBlock = confirmBlock;
}


#pragma mark -UIPickerViewDelegate
//返回指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return self.frame.size.width;
}

//返回指定行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED {
    return 30.0f;
}


//自定义行的视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30.0f)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [[self.locationArray objectAtIndex:row] objectForKey:self.keyArray[0]];
    [view addSubview:label];
    return view;
}

//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
    NSDictionary *location = self.locationArray[row];
    if (self.keyArray.count == 2) {
        self.location.state = [location objectForKey:self.keyArray[0]];
        self.location.city_code = [location objectForKey:self.keyArray[1]];
    } else {
        self.location.state = [location objectForKey:self.keyArray[0]];
    }
  

}





#pragma mark -UIPickerViewDataSource

// UIPickerView有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


// UIPickerView指定行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
        return self.locationArray.count;
    
}



@end
