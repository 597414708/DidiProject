//
//  PeiSongInforVC.m
//  iOSDiDidadaProjiect
//
//  Created by SuperMan on 2018/7/24.
//  Copyright © 2018年 程磊. All rights reserved.
//

#import "PeiSongInforVC.h"
#import "JYEqualCellSpaceFlowLayout.h"
#import "PeisongTypeCell.h"
#import "ListModel.h"

@interface PeiSongInforVC ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UITextField *nametf;
@property (weak, nonatomic) IBOutlet UITextField *numtf;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UITextField *addresstf;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet UIView *fourthView;

@end

@implementation PeiSongInforVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self creatData];
    [self updateHeadFram:4];
}

- (void)viewDidLayoutSubviews {
    
}

- (void)creatData {
    ListModel *model1 = [[ListModel alloc] init];
    model1.className = @"快递保单";
    model1.state = @"1";
    
    ListModel *model2 = [[ListModel alloc] init];
    model2.className = @"网点配送";
    model2.state = @"0";
    
    ListModel *model3 = [[ListModel alloc] init];
    model3.className = @"网点自取";
    model3.state = @"0";
    
    [self.dataSource addObject:model1];
    [self.dataSource addObject:model2];
    [self.dataSource addObject:model3];
}

- (void)creatUI {
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"配送信息";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;
    
    self.myTableView.backgroundColor = kCOLOR_HEX(0xeeeeee);
    
    self.finishBtn.layer.cornerRadius = 4;
    self.finishBtn.layer.masksToBounds = YES;
    
    
    JYEqualCellSpaceFlowLayout *myLayout = [[JYEqualCellSpaceFlowLayout alloc]initWithType:AlignWithCenter betweenOfCell:10];
    myLayout.minimumLineSpacing = 0;
    myLayout.itemSize = CGSizeMake((TheW - 40) / 3.0, 80);
    myLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.myCollectionView.collectionViewLayout = myLayout;
    self.myCollectionView.delegate = self;
    self.myCollectionView.dataSource = self;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"PeisongTypeCell" bundle:nil] forCellWithReuseIdentifier:@"PeisongTypeCell"];
    self.myCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)updateHeadFram:(NSInteger)count {
    [self.myTableView beginUpdates];
    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = 80 + 5 + 2 + 50 * count;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PeisongTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PeisongTypeCell" forIndexPath:indexPath];
    ListModel *model = self.dataSource[indexPath.row];
    [cell showListData:model];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (ListModel *model in self.dataSource) {
        model.state = @"0";
    }
    ListModel *model = self.dataSource[indexPath.row];
    model.state = @"1";
    [self.myCollectionView reloadData];
    
    if (indexPath.row == 2) {
        self.threeView.hidden = YES;
        self.fourthView.hidden = YES;
        [self updateHeadFram:2];
    } else {
        self.threeView.hidden = NO;
        self.fourthView.hidden = NO;
        [self updateHeadFram:4];

    }
}
- (void)dealloc
{
    MyLog(@"-PeiSongInforVC-释放");
    
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
