//
//  CarTypeViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/23.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "CarTypeViewController.h"
#import "ChoseTableViewCell.h"
#import "InsuredPlanViewController.h"



@interface CarTypeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mySeg;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UILabel *firstLab;
@property (weak, nonatomic) IBOutlet UILabel *secondLab;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation CarTypeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.firstLab.hidden = NO;
    self.secondLab.hidden = YES;
    [self creatUI];
    [self creatData:0];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)creatUI {
    
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
    
    NSDictionary *sedic = [NSDictionary dictionaryWithObjectsAndKeys:APPColor,NSForegroundColorAttributeName,nil];
    NSDictionary *nodic = [NSDictionary dictionaryWithObjectsAndKeys:kCOLOR_HEX(0x999999),NSForegroundColorAttributeName,nil];
    [self.mySeg setTitleTextAttributes:nodic forState:UIControlStateNormal];
    
    [self.mySeg setTitleTextAttributes:sedic forState:UIControlStateSelected];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"选择车型";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.rowHeight = 90;
    [self.myTableView registerNib:[UINib nibWithNibName:@"ChoseTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChoseCell"];
}


- (IBAction)selectIndex:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.firstLab.hidden = NO;
        self.secondLab.hidden = YES;
    } else {
        self.firstLab.hidden = YES;
        self.secondLab.hidden = NO;
    }
    [self creatData:sender.selectedSegmentIndex];
}

- (void)creatData:(NSInteger)index {
    
    NSMutableDictionary *dic = @{@"licenseNo":self.inforModel.licenseNo,
                                 @"cityCode":self.inforModel.cityCode
                                 }.mutableCopy;
    if(index == 1 ){
        [dic setObject:@"0" forKey:@"isNeedCarVin"];
        [dic setObject:self.inforModel.modleName forKey:@"moldName"];
        
    } else if (index == 0) {
        [dic setObject:@"1" forKey:@"isNeedCarVin"];
        [dic setObject:self.inforModel.carVin forKey:@"carVin"];
        [dic setObject:self.inforModel.engineNo forKey:@"engineNo"];
        
    }

    [MBProgressHUD showHUDAddedTo:nil animated:YES];
    [APIManager BaoxianCarmodeoListWithParameters:dic success:^(id data) {

        NSArray *dataArray = data[@"items"];
        self.dataSource = [CarTypeModel mj_objectArrayWithKeyValuesArray:dataArray];
        for (CarTypeModel *model in self.dataSource) {
            model.select = @"0";
        }
        if (self.dataSource.count != 0) {
            CarTypeModel *model = self.dataSource.firstObject;
            model.select = @"1";
        }
        [self.myTableView reloadData];
    } failure:^(NSError *error) {

    }];
//

}

- (IBAction)nextAction:(UIButton *)sender {
    
    if (self.dataSource.count > 0) {
        CarTypeModel *senderModel = [[CarTypeModel alloc] init];
        for (CarTypeModel *model in self.dataSource) {
            if ([model.select isEqualToString:@"1"]) {
                senderModel = model;
            }
        }
        if (self.myBlock) {
            self.myBlock(senderModel);
        }
    }
  
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChoseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CarTypeModel *modelList = self.dataSource[indexPath.row];
    [cell showData:modelList];
    
    [cell setMyBlock:^(UIButton *sender){
        CarTypeModel *model = [self getModelWith:sender];
        for (CarTypeModel *modelS in self.dataSource) {
            modelS.select = @"0";
        }
        model.select = @"1";
        [self.myTableView reloadData];
    }];
    return cell;
}

- (CarTypeModel *)getModelWith:(UIButton *)sender {
    NSIndexPath *path = [self getIndexWith:sender];
    CarTypeModel *model = self.dataSource[path.row];
    return model;
}


- (NSIndexPath *)getIndexWith:(UIButton *)sender {
    ChoseTableViewCell *cell = (ChoseTableViewCell *)sender.superview.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
}


- (void)dealloc
{
    MyLog(@"-CarTypeViewController-释放");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
