//
//  CityWithIdPickView.m
//  IOSSumgoTeaProject
//
//  Created by 翁武勇 on 16/11/22.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "CityWithIdPickView.h"

@implementation CityWithIdPickView
{
    UIPickerView *_cityPickView;
    NSArray *_arrInfo; //存储的是整个dic
    NSArray *_provinceArr;//选中某个省后，从_arrInfo里取出放在这个里面
    NSArray *_cityArr;     //选中某个市后，从_provinceArr中取出放在这里;
    NSArray *_townArr;
    
//    NSArray *_provinceNameArray;    //所有省市的名字数组
//    NSArray *_cityNameArray;        //城市数组
//    NSArray *_townNameArray;        //城镇array
    
    UIView *_toolsView; //上方的确定取消工具栏
}


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"AllCityWithID" ofType:@"plist"];
        _arrInfo = [[NSArray alloc] initWithContentsOfFile:path];
        
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in _arrInfo) {
            [temp addObject:dic[@"name"]];
        }
//        _provinceNameArray = temp;//省份数组
        
        //取第1个省,先取第1个，在用省份名字取
        _provinceArr = _arrInfo;
        _cityArr = [_provinceArr[0] objectForKey:@"children"];
        _townArr = [_cityArr[0] objectForKey:@"children"];
        
        _province = [_provinceArr[0] objectForKey:@"name"];
        _provinceId = [_provinceArr[0] objectForKey:@"id"];
        _city = [_cityArr[0] objectForKey:@"name"];
        _cityId = [_cityArr[0] objectForKey:@"id"];
        _area = @"";
        _areaId = @"";
        
        _cityPickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40,self.frame.size.width,self.frame.size.height-40)];
        _cityPickView.layer.borderColor = [UIColor grayColor].CGColor;
        _cityPickView.layer.borderWidth = 0.0;
        _cityPickView.delegate = self;
        _cityPickView.dataSource = self;
        [self addSubview:_cityPickView];
        
        
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:_toolsView];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-77, 0, 77, 40)];
        //button.backgroundColor = [UIColor lightGrayColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectIt) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:button];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 77, 40)];
        //button.backgroundColor = [UIColor lightGrayColor];
        [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button2 setTitle:@"取消" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(cancelIt) forControlEvents:UIControlEventTouchUpInside];
        [_toolsView addSubview:button2];
        
    }
    return self;
}

- (void)selectIt{
    if (_areaId.length>0) {
        self.doneBlock(_province,_city,_area,_provinceId,_cityId,_areaId);
    }else{
        _area = @"";
        _areaId = @"";
        self.doneBlock(_province,_city,_area,_provinceId,_cityId,_areaId);
    }

    
}
- (void)cancelIt{
    self.cancelblock();
}

- (void)setToolshidden:(BOOL)toolshidden{
    _toolshidden = toolshidden;
    if (_toolshidden) {
        _toolsView.hidden = YES;
    }
}

#pragma mark pickView-delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _provinceArr.count;
    }
    else if (component == 1){
        return _cityArr.count;
    }else if (component == 2){
        return _townArr.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = [_provinceArr[row] objectForKey:@"name"];
    }else if (component == 1){
        label.text = [_cityArr[row] objectForKey:@"name"];
    }else if (component == 2){
        if (_townArr.count > 0) {
            label.text = [_townArr[row] objectForKey:@"name"];
        } else {
            label.text = @"";
        }
    }
    
    return label;
}

//三级联动从这里开始
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //这里是选中了省-然后根据省获取城市--在根据城市
    if (component == 0 ) {
        _cityArr = [_provinceArr[row] objectForKey:@"children"];
        _townArr = [_cityArr[0] objectForKey:@"children"];
        [_cityPickView reloadComponent:1];
        [_cityPickView selectRow:0 inComponent:1 animated:YES];
        [_cityPickView reloadComponent:2];
        [_cityPickView selectRow:0 inComponent:2 animated:YES];
        
        _province = [_provinceArr[row] objectForKey:@"name"];
        _provinceId = [NSString stringWithFormat:@"%@",[_provinceArr[row] objectForKey:@"id"]];
        _city = [_cityArr[0] objectForKey:@"name"];
        _cityId = [NSString stringWithFormat:@"%@",[_cityArr[0] objectForKey:@"id"]];
        if (_townArr.count>0) {
            _area = [_townArr[0] objectForKey:@"name"];
            _areaId = [NSString stringWithFormat:@"%@",[_townArr[0] objectForKey:@"id"]];
        }else{
            _areaId = @"";
            _area = @"";
        }
    }else if (component == 1){  //这里是选中市的时候发生的变化
        _townArr = [_cityArr[row] objectForKey:@"children"];
        [_cityPickView reloadComponent:2];
        [_cityPickView selectRow:0 inComponent:2 animated:YES];
        
        
        _city = [_cityArr[row] objectForKey:@"name"];
        _cityId = [NSString stringWithFormat:@"%@",[_cityArr[row] objectForKey:@"id"]];
        if (_townArr.count>0) {
            _area = [_townArr[0] objectForKey:@"name"];
            _areaId = [NSString stringWithFormat:@"%@",[_townArr[0] objectForKey:@"id"]];
        }else{
            _area = @"";
            _areaId = @"";
        }
    }else if (component == 2){
        if (_townArr.count>0) {
            _area = [_townArr[row] objectForKey:@"name"];
            _areaId = [NSString stringWithFormat:@"%@",[_townArr[row] objectForKey:@"id"]];
        }else{
            _area = @"";
            _areaId = @"";
        }
    }

}


- (void)setDefaultAddress{
    for (NSDictionary *dic in _provinceArr) {
        if ([dic[@"id"] integerValue] == [self.provinceId integerValue]) {
            [_cityPickView selectRow:[_provinceArr indexOfObject:dic] inComponent:0 animated:NO];
            _cityArr = [_provinceArr[[_provinceArr indexOfObject:dic]] objectForKey:@"children"];
            [_cityPickView reloadComponent:1];
            break;
        }
    }
    for (NSDictionary *dic in _cityArr) {
        if ([dic[@"id"] integerValue] == [self.cityId integerValue]) {
            [_cityPickView selectRow:[_cityArr indexOfObject:dic] inComponent:1 animated:NO];
            _townArr = [_cityArr[[_cityArr indexOfObject:dic]] objectForKey:@"children"];
            [_cityPickView reloadComponent:2];
            break;
        }
    }
    for (NSDictionary *dic in _townArr) {
        if ([dic[@"id"] integerValue] == [self.areaId integerValue]) {
            [_cityPickView selectRow:[_townArr indexOfObject:dic] inComponent:2 animated:NO];
            break;
        }
    }
}

@end
