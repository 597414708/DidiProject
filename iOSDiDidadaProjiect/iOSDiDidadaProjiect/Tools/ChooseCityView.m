//
//  ChooseCityView.m
//  Modo
//
//  Created by 敲代码mac1号 on 16/9/5.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "ChooseCityView.h"


#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

@interface ChooseCityView ()

@end

@implementation ChooseCityView

- (HZLocation *)locate {
    if (!_locate) {
        self.locate = [[HZLocation alloc] init];
    }
    return _locate;
}

+ (ChooseCityView *)creatChooseCityViewWithDataSource:(NSMutableArray *)dataSource WithKey:(NSArray *)keyArray {

    ChooseCityView *cityView = [[[NSBundle mainBundle] loadNibNamed:@"ChooseCityView" owner:nil options:nil] firstObject];
    cityView.backgroundColor = [UIColor clearColor];
    cityView.frame = CGRectMake(0, 0, TheW, TheH);
    cityView.provinces = dataSource.mutableCopy;
    cityView.keyArray = keyArray;
    cityView.cities = [[cityView.provinces objectAtIndex:0] objectForKey:cityView.keyArray[0]];
    cityView.locate.state = [[cityView.provinces objectAtIndex:0] objectForKey:cityView.keyArray[1]];
    cityView.locate.city = [[cityView.cities objectAtIndex:0] objectForKey:cityView.keyArray[2]];
    cityView.locate.city_code = [[cityView.cities objectAtIndex:0] objectForKey:cityView.keyArray[3]];

    cityView.cityPikeView.delegate = cityView;
    cityView.cityPikeView.dataSource = cityView;
    
    
    return cityView;
}


- (NSString *)returnDataArray:(NSInteger)componet row:(NSInteger)row{
    
    switch (componet) {
        case 0:
            return [[self.provinces objectAtIndex:row] objectForKey:self.keyArray[1]];
            break;
        case 1:
            return [[self.cities objectAtIndex:row] objectForKey:self.keyArray[2]];
            break;
        default:
            return @"";
            break;
    }
}

- (IBAction)confirmAction:(UIButton *)sender {
    if (self.confirmBlock) {
        self.confirmBlock(self.locate);
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
    return self.frame.size.width / 2;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 2, 30.0f)];

    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = [self returnDataArray:component row:row];
        [view addSubview:label];
    } else {
        label.text = [self returnDataArray:component row:row];
       [view addSubview:label];
    }
    
    return view;
}


//
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED {
    
    switch (component) {
        case 0:
            self.cities = [[self.provinces objectAtIndex:row] objectForKey:self.keyArray[0]];
            [self.cityPikeView selectRow:0 inComponent:1 animated:YES];
            [self.cityPikeView reloadComponent:1];
            
            self.locate.state = [[self.provinces objectAtIndex:row] objectForKey:self.keyArray[1]];
            self.locate.city = [[self.cities objectAtIndex:0] objectForKey:self.keyArray[2]];
            self.locate.city_code = [[self.cities objectAtIndex:0] objectForKey:self.keyArray[3]];
            break;
        case 1:
            self.locate.city = [[self.cities objectAtIndex:row] objectForKey:self.keyArray[2]];
            self.locate.city_code = [[self.cities objectAtIndex:row] objectForKey:self.keyArray[3]];

            break;
        default:
            break;
    }
}





#pragma mark -UIPickerViewDataSource

// UIPickerView有几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


// UIPickerView指定行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.provinces count];
            break;
        case 1:

            return [self.cities count];
            break;
        default:
            return 0;
            break;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
