//
//  GoodsDetailViewController.m
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/11/3.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "GoodsDetailViewController.h"

#import "SDCycleScrollView.h"

#import "GoodsSecondTableViewCell.h"

#import "StoreCommentCell.h"

#import "GoodsOrderViewController.h"

@interface GoodsDetailViewController () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate, UIWebViewDelegate>
{
    NSArray *goodsBanner;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) SDCycleScrollView *topPhotoBoworr;
@property (weak, nonatomic) IBOutlet UIView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *goodsDetailsBtn;
@property (weak, nonatomic) IBOutlet UIButton *parameterBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, strong) UIWebView *myWebView;

@property (nonatomic, strong) NSMutableArray *shopCarDataSource;
@property (weak, nonatomic) IBOutlet UIView *bootomView;

@end

@implementation GoodsDetailViewController

- (SDCycleScrollView *)topPhotoBoworr{
    if (_topPhotoBoworr == nil) {
        _topPhotoBoworr = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, TheW, TheW - 64) delegate:self placeholderImage:nil];
        _topPhotoBoworr.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _topPhotoBoworr.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//        _topPhotoBoworr.cellSpace = 4;
        _topPhotoBoworr.titleLabelHeight = 60;
        _topPhotoBoworr.autoScroll = YES;
        _topPhotoBoworr.currentPageDotImage = [UIImage imageNamed:@"pic_bani_s"];
        _topPhotoBoworr.pageDotImage = [UIImage imageNamed:@"pic_bani_n"];
        _topPhotoBoworr.imageURLStringsGroup = goodsBanner;
    }
    return _topPhotoBoworr;
}

- (NSMutableArray *)shopCarDataSource {
    if (!_shopCarDataSource) {
        self.shopCarDataSource = [NSMutableArray array];
    }
    return _shopCarDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    goodsBanner = [self.model.goodsBanner componentsSeparatedByString:@","];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NearListCell"];

    self.goodsDetailsBtn.selected = YES;
    
    self.tag = 1;
    [self creatUI];
    [self creatData];
    
    if (self.hide) {
        self.bootomView.hidden = YES;
    } else {
        self.bootomView.hidden = NO;

    }
    
    [self.headImageView addSubview:self.topPhotoBoworr];
}

- (void)creatUI{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLab.textColor = APPblackColor;
    titleLab.text = @"商品详情";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:TitleFontSize];
    self.navigationItem.titleView = titleLab;

    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"GoodsSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"Second"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"StoreCommentCell" bundle:nil] forCellReuseIdentifier:@"Three"];

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.myWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.myWebView.delegate = self;
    self.myWebView.userInteractionEnabled = NO;
    self.myWebView.scrollView.bounces = NO;
    
    self.titleLab.text = self.model.name;
    
    self.priceLab.text = [NSString stringWithFormat:@"¥ %@", self.model.price];
}

- (void)creatData {
    NSMutableDictionary *dic = @{@"id": self.model.id}.mutableCopy;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [APIManager GetGoodsDetailWithParameters:dic success:^(id data) {
        NSDictionary *dic = data;
        GoodsModel *model = [GoodsModel mj_objectWithKeyValues:dic];
        self.model = model;
        [self.myWebView loadHTMLString:[NSString stringWithFormat:@"<div id=\"webview_content_wrapper\">%@</div>", model.goodsDetail] baseURL:nil];
        [self.myTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

// 加入购物车
- (IBAction)addShopCarAction:(UIButton *)sender {
    NSString *sessionId = [userDef objectForKey: USERID];
    if (sessionId.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        return;
    }
    NSMutableDictionary *dic = @{@"goodsId": self.model.id,
                                 @"shopId" : @"1",
                                 @"num" :@"1"
                                 }.mutableCopy;
    [APIManager ShopcartaddWithParameters:dic success:^(id data) {
        [MBProgressHUD showMessage:@"添加成功" toView:nil];
    } failure:^(NSError *error) {
        
    }];
    
}


- (IBAction)buyAction:(UIButton *)sender {
    NSString *sessionId = [userDef objectForKey: USERID];
    if (sessionId.length == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LogVC object:nil];
        return;
    }
    
    [self.shopCarDataSource removeAllObjects];
    GoodsOrderViewController *goodsOrderVC = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"GoodsOrderVC"];
    self.hidesBottomBarWhenPushed = YES;

    [self.shopCarDataSource addObject:self.model];
    
    goodsOrderVC.dataSource = self.shopCarDataSource;
    
    [self.navigationController pushViewController:goodsOrderVC animated:YES];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
    CGRect newFrame = webView.frame;
    newFrame.size.height = actualSize.height;
    webView.frame = newFrame;
    NSString *str=[NSString stringWithFormat:@"var script = document.createElement('script');"
                   "script.type = 'text/javascript';"
                   "script.text = \"function ResizeImages() { "
                   "var myimg,oldwidth;"
                   "var maxwidth =%f;" // UIWebView中显示的图片宽度
                   "for(i=0;i <document.images.length;i++){"
                   "myimg = document.images[i];"
                   "if(myimg.width > maxwidth){"
                   "oldwidth = myimg.width;"
                   "myimg.width = maxwidth;"
                   "}"
                   "}"
                   "}\";"
                   "document.getElementsByTagName('head')[0].appendChild(script);",TheW - 15];
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //获取页面高度（像素）
    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    //设置到WebView上
    webView.frame = CGRectMake(0, 0, TheW, clientheight);
    //获取WebView最佳尺寸（点）
    CGSize frame = [webView sizeThatFits:webView.frame.size];
    //获取内容实际高度（像素）
    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    //内容实际高度（像素）* 点和像素的比
    height = height * frame.height / clientheight;
    
    //再次设置WebView高度（点）
    webView.frame = CGRectMake(0, 0, TheW, height);
    
    [self.myTableView beginUpdates];
    [self.myTableView setTableFooterView:self.myWebView];
    [self.myTableView endUpdates];
}

- (IBAction)selectTapAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    
    NSArray *btnArray = @[self.goodsDetailsBtn, self.parameterBtn, self.commentBtn];
    sender.selected = !sender.selected;
    
    for (UIButton *btn in btnArray) {
        if (btn == sender) {

        } else {
            btn.selected = !sender.selected;
        }
    }
    
    self.tag = sender.tag - 100;
    [self.myTableView reloadData];
    
    if (self.tag == 1) {
        [self.myTableView beginUpdates];
        [self.myTableView setTableFooterView:self.myWebView];
        [self.myTableView endUpdates];
    } else {
        [self.myTableView beginUpdates];
        [self.myTableView setTableFooterView:[UIView new]];
        [self.myTableView endUpdates];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.myTableView beginUpdates];

    CGRect headerFrame = self.myTableView.tableHeaderView.frame;
    headerFrame.size.height = TheW - 64 + 70 + 50 + 45 + 3;
    //修改tableHeaderView的frame
    self.myTableView.tableHeaderView.frame = headerFrame;
    [self.myTableView endUpdates];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.tag == 1) {
        if (self.model.goodsDetail) {
            return 0;
        } else {
            return 0;
        }
    } else if (self.tag == 2) {
        return self.model.paramList.count;
    } else {
        return self.model.evolutionList.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.tag == 1) {
      
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    } else if (self.tag == 2) {
        GoodsSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Second" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ParamModel *model = self.model.paramList[indexPath.row];
        [cell showData:model];
        return cell;
    } else {
        StoreCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Three" forIndexPath:indexPath];
        CommentModel *model = self.model.evolutionList[indexPath.row];
        [cell showDataWith:model];
        return cell;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tag == 1) {
        return TheH * 3;
    } else if (self.tag == 2) {
        return  50;
    } else {
        return 100;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MyLog(@"-GoodsDetailViewController-释放");
    
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
