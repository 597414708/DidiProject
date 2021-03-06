//
//  ChooseTimeViewController.m
//  shijian
//
//  Created by IOS_MAC PRO on 2017/4/6.
//  Copyright © 2017年 com.ASS. All rights reserved.
//

#import "ChooseTimeViewController.h"
#import "ChooseTimeCollectionViewCell.h"
#import "ZYInputAlertFieldView.h"

@interface ChooseTimeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak)UIButton *selectbtn;
@property(nonatomic,weak)UIView *bgView;
@property(nonatomic,weak)UIButton *submitbtn;

@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)BOOL ShowTomorrow;
@property(nonatomic,nonnull,strong)NSArray * weakArray;
@property(nonatomic,strong)NSMutableArray* selectIndexPathArray;
@property(nonatomic,assign)NSTimeInterval selectTimeInterval;


@end

@implementation ChooseTimeViewController

- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectIndexPathArray{
    
    if (_selectIndexPathArray == nil) {
        _selectIndexPathArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1", nil];
    }
    return _selectIndexPathArray;
}

- (NSArray *)weakArray{
    
    if (_weakArray == nil) {
        _weakArray = @[@"周六",@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    }
    return _weakArray;
}
- (UIView *)lineView{
    
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = APPColor;
    }
    return _lineView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择服务时间";
    
    if (self.timeInterval == 0) {
        self.timeInterval = 30;
    }
    
    [self dateDataProcessing:[NSDate date]];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    CGFloat btnW = self.view.frame.size.width*0.2;
    for (int i = 0; i < 5; i++) {
        
        NSDate * date ;
        NSString * timetitle;
        
        NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        if (self.ShowTomorrow) {
            date = [NSDate dateWithTimeInterval:24*60*60*(i+1) sinceDate:[NSDate date]];
            NSDateComponents *comps1 = [calendar components:NSCalendarUnitWeekday fromDate:date];
            
            if (i == 0) {
                timetitle = [NSString stringWithFormat:@"%@\n%@",@"明天",[self detailedStringWithDate:date type:@"MM月dd"]];
            }else if (i == 1){
                timetitle = [NSString stringWithFormat:@"%@\n%@",@"后天",[self detailedStringWithDate:date type:@"MM月dd"]];
            }else{
                timetitle = [NSString stringWithFormat:@"%@\n%@",self.weakArray[comps1.weekday%7],[self detailedStringWithDate:date type:@"MM月dd"]];
            }
        }else{
            date = [NSDate dateWithTimeInterval:24*60*60*i sinceDate:[NSDate date]];
            NSDateComponents *comps1 = [calendar components:NSCalendarUnitWeekday fromDate:date];
            
            if (i == 0) {
                timetitle = [NSString stringWithFormat:@"%@\n%@",@"今天",[self detailedStringWithDate:date type:@"MM月dd"]];
            }else if (i == 1){
                timetitle = [NSString stringWithFormat:@"%@\n%@",@"明天",[self detailedStringWithDate:date type:@"MM月dd"]];
            }else{
                timetitle = [NSString stringWithFormat:@"%@\n%@",self.weakArray[comps1.weekday%7],[self detailedStringWithDate:date type:@"MM月dd"]];
            }
        }
        UIButton * timetitlebtn = [self topButton:timetitle];
        [topView addSubview:timetitlebtn];
        timetitlebtn.tag = i;
        timetitlebtn.frame = CGRectMake(i*btnW, 0, btnW, topView.frame.size.height - 1);
        
        if (i == 0) {
            timetitlebtn.selected = YES;
            self.selectbtn = timetitlebtn;
        }
    }
    self.lineView.frame = CGRectMake(0, topView.frame.size.height - 1.5, btnW, 1);
    [topView addSubview:self.lineView];
    [self.view addSubview:topView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.frame.size.width, 13)];
    [flowLayout setFooterReferenceSize:CGSizeMake(self.view.frame.size.width, 13)];
    [flowLayout setItemSize:CGSizeMake((self.view.frame.size.width - 40 - 13*2)*0.2, 40)];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+50, self.view.frame.size.width, 0)];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1].CGColor;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(13, 50, self.view.frame.size.width - 13*2, self.view.frame.size.height - 184) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    [collectionView registerNib:[UINib nibWithNibName:@"ChooseTimeCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ChooseTimeCell"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIButton * submitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitbtn.layer.cornerRadius = 5;
    submitbtn.layer.masksToBounds = YES;
    [submitbtn setTitle:@"确认选择" forState:UIControlStateNormal];
    [submitbtn setBackgroundColor:APPColor];
    [submitbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    submitbtn.frame = CGRectMake(13, self.view.frame.size.height - 120, self.view.frame.size.width - 13*2, 50);
    [submitbtn addTarget:self action:@selector(submitbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitbtn];
    self.submitbtn = submitbtn;
    self.submitbtn.hidden = YES;
}

- (UIButton *)topButton:(NSString *)Buttontitle{
    
    UIButton * timetitlebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSMutableAttributedString * selectattString = [[NSMutableAttributedString alloc]initWithString:Buttontitle];
    [selectattString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 2)];
    [selectattString addAttribute:NSForegroundColorAttributeName value:APPColor range:NSMakeRange(0, Buttontitle.length)];
    NSMutableParagraphStyle *selectparaStyle = [[NSMutableParagraphStyle alloc] init];
    selectparaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    selectparaStyle.lineSpacing = 5;
    selectparaStyle.alignment = NSTextAlignmentCenter;
    [selectattString addAttribute:NSParagraphStyleAttributeName value:selectparaStyle range:NSMakeRange(0, Buttontitle.length)];
    [timetitlebtn setAttributedTitle:selectattString forState:UIControlStateSelected];
    
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc]initWithString:Buttontitle];
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, 2)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(2, Buttontitle.length - 2)];
    [attString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 2)];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = 5;
    paraStyle.alignment = NSTextAlignmentCenter;
    [attString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, Buttontitle.length)];
    [timetitlebtn setAttributedTitle:attString forState:UIControlStateNormal];
    
    timetitlebtn.titleLabel.numberOfLines = 0;
    timetitlebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [timetitlebtn addTarget:self action:@selector(topbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    return timetitlebtn;
}

- (void)dateDataProcessing:(NSDate *)date{
    
    [self.dataArray removeAllObjects];
    
    BOOL isAcross = false;
    
    NSString * currendataY = [self detailedStringWithDate:date type:@"yyyy"];
    NSString * currendataM = [self detailedStringWithDate:date type:@"MM"];
    NSString * currendataD = [self detailedStringWithDate:date type:@"dd"];
    
    NSString* startwork = [NSString stringWithFormat:@"%@-%@-%@ %@",currendataY,currendataM,currendataD,self.startTime];
    NSString* afterwork = [NSString stringWithFormat:@"%@-%@-%@ %ld:00",currendataY,currendataM,currendataD,[self.endTime integerValue]];
    
    NSTimeInterval startworkInterval = [self dateOfDatestr:startwork];
    NSTimeInterval afterworkInterval = [self dateOfDatestr:afterwork];
    
    NSTimeInterval currenTimeInterval = 0;
    
    if (self.ShowTomorrow) {
        currenTimeInterval = startworkInterval;
    }else{
        if (self.selectbtn.tag > 0) {
            currenTimeInterval = startworkInterval;
        }else{
            currenTimeInterval = [[NSDate date] timeIntervalSince1970];
        }
    }
    
    NSTimeInterval startInterval = 0;
    NSTimeInterval endInterval = 0;
    
    if (startworkInterval > afterworkInterval || startworkInterval == afterworkInterval) {//跨天选择时间
        
        NSString* dayendstarstr = [NSString stringWithFormat:@"%@-%@-%ld %@",currendataY,currendataM,[currendataD integerValue],@"23:59"];
        endInterval = [self dateOfDatestr:dayendstarstr];
        
        NSString* daystartstarstr = [NSString stringWithFormat:@"%@-%@-%ld %@",currendataY,currendataM,[currendataD integerValue],@"0:00"];
        startInterval = [self dateOfDatestr:daystartstarstr];
        isAcross = YES;
        
        if (self.ShowTomorrow) {
            currenTimeInterval = startInterval;
        }else{
            if (self.selectbtn.tag > 0) {
                currenTimeInterval = startInterval;
            }else{
                currenTimeInterval = [[NSDate date] timeIntervalSince1970];
            }
        }
    }else{
        if (currenTimeInterval < startworkInterval){
            
            startInterval = startworkInterval;
            endInterval = afterworkInterval - 1000;
            
        }else if (currenTimeInterval> afterworkInterval - 1800){
            //显示明天时间
            
            NSString* afterstartwork = [NSString stringWithFormat:@"%@-%@-%ld %@",currendataY,currendataM,[currendataD integerValue]+1,self.startTime];
            self.ShowTomorrow = YES;
            [self dateDataProcessing:[NSDate dateWithTimeIntervalSince1970:[self dateOfDatestr:afterstartwork]]];
            
        }else{
            startInterval = currenTimeInterval ;
            endInterval = afterworkInterval- 1000;
        }
    }
    
    NSString * dataste = [self detailedStringWithDate:[NSDate dateWithTimeIntervalSince1970:currenTimeInterval] type:@"HH:mm"];
    int nowF = [[[dataste componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
    int nowH = [[[dataste componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
    
    NSString * timestr;
    
    if (startInterval != startworkInterval) {
        if (nowF> 30) {
            timestr = [NSString stringWithFormat:@"%@-%@-%@ %d:30",currendataY,currendataM,currendataD,nowH+1];
            startInterval = [self dateOfDatestr:timestr];
            
        }else if (nowF == 0){
            
            timestr = [NSString stringWithFormat:@"%@-%@-%@ %d:00",currendataY,currendataM,currendataD,nowH];
            startInterval = [self dateOfDatestr:timestr];
        }else{
            timestr = [NSString stringWithFormat:@"%@-%@-%@ %d:00",currendataY,currendataM,currendataD,nowH+1];
            startInterval = [self dateOfDatestr:timestr];
        }
    }
    
    
    for (NSTimeInterval i = startInterval; i<endInterval ; i+=1800) {
        
        if (isAcross) {
            if (i < afterworkInterval + 1 || i> startworkInterval-1) {
                [self.dataArray addObject:@(i)];
            }
        }else{
            [self.dataArray addObject:@(i)];
        }
    }
    
    [self.collectionView reloadData];
}

- (void)topbtnclick:(UIButton *)btn{
    
    self.selectbtn.selected = NO;
    self.selectbtn = btn;
    self.selectbtn.selected = YES;
    
    NSDate *newDate ;
    if (self.ShowTomorrow) {
        newDate = [NSDate dateWithTimeInterval:24*60*60*(btn.tag+1) sinceDate:[NSDate date]];
    }else{
        newDate = [NSDate dateWithTimeInterval:24*60*60*btn.tag sinceDate:[NSDate date]];
    }
    
    [self dateDataProcessing:newDate];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = btn.frame.origin.x;
        self.lineView.frame = rect;
    }completion:^(BOOL finished) {
        //        [UIView animateWithDuration:0.2 animations:^{
        //            CGRect rect = self.lineView.frame;
        //            rect.size.width = self.view.frame.size.width/5;
        //            self.lineView.frame = rect;
        //            
        //        }];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    CGRect frame = CGRectMake(self.bgView.frame.origin.x, self.bgView.frame.origin.y, self.bgView.frame.size.width, 16+(([self.dataArray count]+4)/5)*50);
    self.bgView.frame = frame;
    return [self.dataArray count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = headerview;
    }
    
    if (kind == UICollectionElementKindSectionFooter)
    {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableView = footerview;
    }
    return reusableView;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseTimeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChooseTimeCell" forIndexPath:indexPath];
    cell.titleLabel.layer.cornerRadius = 4;
    cell.titleLabel.layer.borderWidth = 0.5;
    cell.titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.titleLabel.layer.masksToBounds = YES;
    cell.titleLabel.backgroundColor = [UIColor whiteColor];
    
    NSIndexPath * selectIndexPath = self.selectIndexPathArray[self.selectbtn.tag];
    if ([selectIndexPath isKindOfClass:[NSIndexPath class]]) {
        if (indexPath.row == selectIndexPath.row && indexPath.section == selectIndexPath.section ) {
            cell.titleLabel.backgroundColor = APPColor;
        } else {
//            cell.titleLabel.backgroundColor = [UIColor whiteColor];
//            cell.titleLabel.textColor = [UIColor blackColor];
        }
    }
    
    NSInteger time = [self.dataArray[indexPath.row] integerValue];
    cell.titleLabel.text = [self detailedStringWithDate:[NSDate dateWithTimeIntervalSince1970:time] type:@"HH:mm"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i = 0; i<self.selectIndexPathArray.count; i++) {
        [self.selectIndexPathArray replaceObjectAtIndex:i withObject:@"1"];
    }
    [self.selectIndexPathArray replaceObjectAtIndex:self.selectbtn.tag withObject:indexPath];
    
    NSIndexPath * selectindexpath = self.selectIndexPathArray[self.selectbtn.tag];
    self.selectTimeInterval = [self.dataArray[selectindexpath.row] doubleValue];
    
    [collectionView reloadData];
    self.submitbtn.hidden = NO;

}

- (void)submitbtnclick{
    
    
    
    ZYInputAlertFieldView *alertView = [ZYInputAlertFieldView alertView];
    alertView.inputTextView.hidden = YES;
    alertView.tfHeight.constant = 80;
    alertView.secondField.placeholder = @"请填写服务备注";
    [alertView confirmBtnClickBlock:^(NSString *inputString, NSString *second) {
        if (second.length == 0) {
            [MBProgressHUD showMessage:@"请填写服务备注" toView:self.view];
            return ;
        }
        self.ChooseTimeConfirmClickBlock(self.selectTimeInterval, second);
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertView show];
   
}

- (NSTimeInterval)dateOfDatestr:(NSString *)datestr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate * date = [formatter dateFromString:datestr];
    return [date timeIntervalSince1970];
}

- (NSString *)detailedStringWithDate:(NSDate *)date type:(NSString *)type{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:type];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString * datestr = [formatter stringFromDate:date];
    return datestr;
}

- (void)dealloc
{
    MyLog(@"-ChooseTimeViewController-释放");
    
}

@end
