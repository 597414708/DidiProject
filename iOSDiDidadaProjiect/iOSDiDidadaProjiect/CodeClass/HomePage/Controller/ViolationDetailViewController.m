//
//  ViolationDetailViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/12/13.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ViolationDetailViewController.h"
#import "InforListTableViewCell.h"

@interface ViolationDetailViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *classNameArrayI;
    NSArray *classNameArrayII;
    
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@end

@implementation ViolationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    classNameArrayI = @[@"违章时间",@"违章地点",@"违章行为", @"违章处理"];
    classNameArrayII = @[@"文书编号",@"违章代码",@"违章记分", @"违章金额"];

    [self creatUI];
}

- (void)creatUI {
    
    self.contentLab.text = self.titleStr;
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"违章查询";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.tableFooterView = [UIView new];
    [self.myTableView registerNib:[UINib nibWithNibName:@"InforListTableViewCell" bundle:nil] forCellReuseIdentifier:@"InforListTableViewCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 60;
    } else {
        return 41;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InforListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InforListTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lineLab.hidden = YES;
    
    if (indexPath.section == 0) {
        cell.classNameLab.text = classNameArrayI[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.contentLab.text = self.model.date;
            }
                break;
            case 1:
            {
                cell.contentLab.text = self.model.area;
            }
                break;
            case 2:
            {
                cell.contentLab.text = self.model.act;
            }
                break;
            case 3:
            {
                if ([self.model.handled isEqualToString:@"1"]) {
                    cell.contentLab.text = @"已处理";
                    cell.contentLab.textColor = APPColor;
                } else {
                    cell.contentLab.text = @"未处理";
                    cell.contentLab.textColor = kCOLOR_HEX(0xFF743E);
                }

            }
                break;
                
            default:
                break;
        }
    }
    
    if (indexPath.section == 1) {
        cell.classNameLab.text = classNameArrayII[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.contentLab.text = self.model.archiveno;
            }
                break;
            case 1:
            {
                cell.contentLab.text = self.model.code;

            }
                break;
            case 2:
            {
                cell.contentLab.text = self.model.fen;

            }
                break;
            case 3:
            {
                cell.contentLab.text = self.model.money;

            }
                break;
                
            default:
                break;
        }
    }
   
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }
    return 0;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TheW, 5)];
        lab.backgroundColor = kCOLOR_HEX(0xeeeeee);
        lab.font = [UIFont systemFontOfSize:13];
        return lab;
    } else {
        return nil;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    MyLog(@"-ViolationDetailViewController-释放");
    
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
