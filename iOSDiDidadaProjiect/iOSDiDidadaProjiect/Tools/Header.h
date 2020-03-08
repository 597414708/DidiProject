//
//  Header.h
//  iOSDiDidadaProjiect
//
//  Created by 程磊 on 2017/10/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define MAS_SHORTHAND

#define MAS_SHORTHAND_GLOBALS

#define iPhoneX [UIScreen mainScreen].bounds.size.height == 812

#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define APPColor Color(39, 180, 185)

#define APPblackColor Color(51, 51, 51)

#define APPGrayColor Color(102, 102, 102)

#define TitleFontSize 15

#define kCOLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define TheW [UIScreen mainScreen].bounds.size.width

#define TheH [UIScreen mainScreen].bounds.size.height

#define MyLog(...) NSLog(__VA_ARGS__)

#define userDef [NSUserDefaults standardUserDefaults]


#define USERID @"userID"

#define HeadImage @"HeadImage"

#define Latitude @"Latitude"
#define Longitude @"Longitude"
#define Dcity @"city"


#define NickName @"NickName"
#define placeHoder [UIImage imageNamed:@"placeholder"]
#define LogVC @"gotoLog"

// Storyboard通过名字获取
#define kStoryboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

#define HelpPramodel [HelpManager shareHelpManager]


// AppDelegate
#define kAppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

#pragma mark - 定义字体大小
#define kFONT_TITLE(X)     [UIFont systemFontSize:X]

#pragma mark - GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define RGB(r, g, b)	 [UIColor colorWithRed: (r) / 255.0 green: (g) / 255.0 blue: (b) / 255.0 alpha : 1]

#define color(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define ImageTheW 417


//#define DiDiDada @"http://192.168.0.103/mobile/"
#define DiDiDada @"http://uddcar.com/mobile/"

#define GetQiNiuToken [NSString stringWithFormat:@"%@/qiniu/getToken", DiDiDada]

#define upLoadUserIamge @"http://image.uddcar.com/"

//微信支付
#define WXpay [NSString stringWithFormat:@"%@weixin/goods/pay", DiDiDada]
#define FenqiWXpay [NSString stringWithFormat:@"%@weixin/fenqi/pay", DiDiDada]

//支付宝支
#define Alipay [NSString stringWithFormat:@"%@alipay/goods/pay", DiDiDada]

#define FenqiAlipay [NSString stringWithFormat:@"%@alipay/fenqi/pay", DiDiDada]

//登录 post
#define Login [NSString stringWithFormat:@"%@user/login", DiDiDada]

//获取个人资料
#define UserFresh [NSString stringWithFormat:@"%@user/fresh", DiDiDada]

//修改个人资料
#define UserEdit [NSString stringWithFormat:@"%@user/edit", DiDiDada]

//注册 post
#define Register [NSString stringWithFormat:@"%@user/register", DiDiDada]

#define UserRestPwd [NSString stringWithFormat:@"%@user/restPwd", DiDiDada]

//验证码 get
#define SmsloginCode [NSString stringWithFormat:@"%@sms/loginCode", DiDiDada]

//店铺商品列表 get
#define GoodsList [NSString stringWithFormat:@"%@goods/list", DiDiDada]

//商品详情 get
#define Goodsdetail [NSString stringWithFormat:@"%@goods/detail", DiDiDada]

//店铺商品分类列表 get
#define GoodsTypelist [NSString stringWithFormat:@"%@goodsType/list", DiDiDada]

//平台分类列表
#define GetShopType [NSString stringWithFormat:@"%@shopType/list", DiDiDada]

//平台商品列表
#define ShopGoodslist [NSString stringWithFormat:@"%@shopGoods/list", DiDiDada]

//添加购物车 post
#define Shopcartadd [NSString stringWithFormat:@"%@shopcart/addOrUpdate", DiDiDada]

//修改购物车 post
#define Shopcartedit [NSString stringWithFormat:@"%@shopcart/edit", DiDiDada]

//删除购物车 get
#define Shopcartdel [NSString stringWithFormat:@"%@shopcart/del", DiDiDada]

//清空购物车 get
#define ShopcartdelAll [NSString stringWithFormat:@"%@shopcart/delAll", DiDiDada]

//购物车列表 get
#define Shopcartlist [NSString stringWithFormat:@"%@shopcart/list", DiDiDada]

//添加收货地址 post
#define Addressadd [NSString stringWithFormat:@"%@address/add", DiDiDada]

//修改地址 post
#define Addressedit [NSString stringWithFormat:@"%@address/edit", DiDiDada]

//收货地址列表 get
#define Addresslist [NSString stringWithFormat:@"%@address/list", DiDiDada]

//删除收货地址 get
#define Addressdel [NSString stringWithFormat:@"%@address/del", DiDiDada]

//获取默认收货地址 get
#define Addressdefault [NSString stringWithFormat:@"%@address/default", DiDiDada]

//附近店铺 get
#define GetNearShop [NSString stringWithFormat:@"%@near/shop", DiDiDada]

//文章列表 get
#define GetArticle [NSString stringWithFormat:@"%@article/list", DiDiDada]

//文章详情
#define GetArticleDetail [NSString stringWithFormat:@"%@article/detail", DiDiDada]

//评论列表
#define GetEvolutionList [NSString stringWithFormat:@"%@evolution/list", DiDiDada]

//发表评论
#define EvolutionAdd [NSString stringWithFormat:@"%@evolution/add", DiDiDada]

//预约列表
#define GetMyOrderList [NSString stringWithFormat:@"%@my/order", DiDiDada]

//预约
#define DoOrderAdd [NSString stringWithFormat:@"%@order/add", DiDiDada]

//取消预约
#define CancelOrder [NSString stringWithFormat:@"%@order/cancel", DiDiDada]

//删除预约
#define DelOrder [NSString stringWithFormat:@"%@order/del", DiDiDada]

//车辆列表
#define GetCarList [NSString stringWithFormat:@"%@car/list", DiDiDada]

//添加车辆
#define DoCarAdd [NSString stringWithFormat:@"%@car/add", DiDiDada]

//修改车辆
#define DoCarEdit [NSString stringWithFormat:@"%@car/edit", DiDiDada]

//删除车辆
#define DoCarDelete [NSString stringWithFormat:@"%@car/del", DiDiDada]

//购物车id 生成订单
#define GetIndentAdd [NSString stringWithFormat:@"%@indent/add", DiDiDada]

//商品id 生成订单
#define GetAddByGoods [NSString stringWithFormat:@"%@indent/addByGoods", DiDiDada]

//订单列表
#define GetIndentList [NSString stringWithFormat:@"%@indent/list", DiDiDada]

//删除订单
#define GetIndentdelete [NSString stringWithFormat:@"%@indent/delete", DiDiDada]

//取消订单
#define GetIndentCancel [NSString stringWithFormat:@"%@indent/cancel", DiDiDada]

//确认收货
#define IndentReceive [NSString stringWithFormat:@"%@indent/receive", DiDiDada]

//申请退货
#define IndentReturnGoods [NSString stringWithFormat:@"%@indent/returnGoods", DiDiDada]

//申请退款
#define IndentReturnMoney [NSString stringWithFormat:@"%@indent/returnMoney", DiDiDada]

//订单详情
#define GetIndentDetail [NSString stringWithFormat:@"%@indent/detail", DiDiDada]

//城市
#define WeizhangCityList [NSString stringWithFormat:@"%@weizhang/city/list", DiDiDada]

/// 险别查询
#define BaoxianRisks [NSString stringWithFormat:@"%@baoxian/risks", DiDiDada]

/// 违章记录查询
#define WeizhangInfo [NSString stringWithFormat:@"%@weizhang/info/list", DiDiDada]

/// 车辆信息
#define BaoxianCarinfo [NSString stringWithFormat:@"%@baoxian/car/info", DiDiDada]

///物流信息
#define ExpressInfo [NSString stringWithFormat:@"%@express/info", DiDiDada]


///平台轮播图
#define BannerList [NSString stringWithFormat:@"%@banner/list", DiDiDada]

///发布
#define ArticleAdd [NSString stringWithFormat:@"%@article/add", DiDiDada]

///申请分期
#define FenqiAdd [NSString stringWithFormat:@"%@fenqi/add", DiDiDada]

///成为店铺信息
#define UserShop [NSString stringWithFormat:@"%@user/shop", DiDiDada]

///申请成为店铺
#define ShoptoShop [NSString stringWithFormat:@"%@shop/toShop", DiDiDada]

///已出账单/未出账单 fenqi/money
#define Fenqimoney [NSString stringWithFormat:@"%@fenqi/money", DiDiDada]

///保单详情
#define BaodanDetail [NSString stringWithFormat:@"%@baodan/detail", DiDiDada]

///保单列表
#define BaodanList [NSString stringWithFormat:@"%@baodan/list", DiDiDada]

//全部账单
#define FenqiBill [NSString stringWithFormat:@"%@fenqi/bill", DiDiDada]

//意见反馈
#define KefuAdd [NSString stringWithFormat:@"%@kefu/add", DiDiDada]

//成为代理
#define ToAgent [NSString stringWithFormat:@"%@agent/toAgent", DiDiDada]

//富文本  type//1常见问题 2平台说明 3关于我们
#define CommonText [NSString stringWithFormat:@"%@common/text", DiDiDada]

//个人首页信息
#define Userhome [NSString stringWithFormat:@"%@user/home", DiDiDada]

///系统信息/客服电话
#define AppVersion [NSString stringWithFormat:@"%@app/version", DiDiDada]

///获取投保起期
#define BaoXianCartToubao [NSString stringWithFormat:@"%@baoxian/car/toubao", DiDiDada]


/********************/

//获取用户车辆信息和去年投保信息
#define BaoxianCarInfo [NSString stringWithFormat:@"%@v2/baoxian/car/info", DiDiDada]

//2请求报价/核保信息 post提交
#define BaoxianPostPrice [NSString stringWithFormat:@"%@v2/baoxian/car/postPrice", DiDiDada]

#define BaoxianGetPrice [NSString stringWithFormat:@"%@v2/baoxian/car/getPrice", DiDiDada]

#define BaoxianHebao [NSString stringWithFormat:@"%@v2/baoxian/car/hebao", DiDiDada]


//可投保省份
#define BaoxianProvinceList [NSString stringWithFormat:@"%@v2/baoxian/city/list", DiDiDada]

///类别
#define AdList [NSString stringWithFormat:@"%@v2/ad/list", DiDiDada]


/// 车型列表
#define BaoxianCarmode [NSString stringWithFormat:@"%@v2/baoxian/car/chexing", DiDiDada]

///保险公司列表
#define BaoxianInsurerList [NSString stringWithFormat:@"%@v2/baoxian/company/list", DiDiDada]

#define QueryRecordList [NSString stringWithFormat:@"%@v2/baoxian/query/record", DiDiDada]

#define AgentInfo [NSString stringWithFormat:@"%@agent/info", DiDiDada]

#define BaojiaCount [NSString stringWithFormat:@"%@v2/baoxian/baojia/count", DiDiDada]

#endif /* Header_h */



