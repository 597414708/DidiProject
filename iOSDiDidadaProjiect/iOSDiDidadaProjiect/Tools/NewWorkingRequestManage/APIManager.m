//
//  APIManager.m
//  IOSStockProject
//
//  Created by 程磊 on 2017/6/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "APIManager.h"
@implementation APIManager


#pragma mark - 登录
///1登录
+ (void)LogonWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure
{
    NSString *path = Login;
    [NewWorkingRequestManage requestLoginPostWith:path parDic:dic finish:success error:failure];
}


///2注册
+ (void)RegisterWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure
{
    NSString *path = Register;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}



///3.获取验证码
+ (void)GetCodeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = SmsloginCode;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///4.店铺商品列表
+ (void)GetGoodsListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GoodsList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///5.商品详情
+ (void)GetGoodsDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = Goodsdetail;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///6.商品分类列表
+ (void)GetGoodsTypelistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GoodsTypelist;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///7.添加购物车
+ (void)ShopcartaddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Shopcartadd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///8.修改购物车
+ (void)ShopcarteditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Shopcartedit;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///9.删除购物车
+ (void)ShopcartdelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Shopcartdel;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///10.清空购物车
+ (void)ShopcartdelAllWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ShopcartdelAll;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///11.购物车列表
+ (void)ShopcartlistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Shopcartlist;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///12.添加收货地址
+ (void)AddressaddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Addressadd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///13.修改地址
+ (void)AddresseditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Addressedit;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///14.收货地址列表
+ (void)AddresslistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Addresslist;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///15.删除收货地址 get
+ (void)AddressdelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Addressdel;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}



///16.获取默认收货地址
+ (void)AddressdefaultWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Addressdefault;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///17.附近商家
+ (void)GetNearShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetNearShop;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///18.文章列表
+ (void)GetArticleWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure{
    NSString *path = GetArticle;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///19.平台分类列表
+ (void)GetShopTypeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetShopType;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///20.平台商品列表
+ (void)GetShopGoodslistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ShopGoodslist;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///21. 评论列表
+ (void)GetGetEvolutionListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetEvolutionList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];    
}

///22. 预约列表
+ (void)GetGetMyOrderListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetMyOrderList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///23. 预约
+ (void)DoOrderAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = DoOrderAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}


///24. 修改个人资料
+ (void)DoUserEditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = UserEdit;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///25. 获取个人资料
+ (void)GetUserFreshWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = UserFresh;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///26. 获取车辆列表
+ (void)GetGetCarListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetCarList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///27. 添加车辆
+ (void)DoCarAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = DoCarAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///28. 删除车辆
+ (void)DoCarDeleteWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = DoCarDelete;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///29. 文章详情
+ (void)GetArticleDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetArticleDetail;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///30. 购物车id 生成订单
+ (void)GetIndentAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetIndentAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///31. 商品id 生成订单
+ (void)GetAddByGoodsWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = GetAddByGoods;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

+ (void)GetIndentListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetIndentList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
    
}


+ (void)WeizhangCityListListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = WeizhangCityList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


+ (void)BaoxianProvinceListListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = BaoxianProvinceList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}




+ (void)BaoxianRisksListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = BaoxianRisks;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

+ (void)WeizhangInfoListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = WeizhangInfo;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}
///38. 车型列表
+ (void)BaoxianCarmodeoListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    
    NSString *path = BaoxianCarmode;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///39. 车辆信息
+ (void)BaoxianCarinfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianCarinfo;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///40. 订单删除
+ (void)GetIndentdeleteWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetIndentdelete;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///41. 订单详情
+ (void)GetIndentDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetIndentDetail;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///42. 物流信息
+ (void)ExpressInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ExpressInfo;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///43. 轮播图
+ (void)BannerListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BannerList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///44. 发布 ArticleAdd
+ (void)ArticleAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ArticleAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}


///45. 地区支持的保险公司
+ (void)BaoxianInsurerListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianInsurerList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


///48.提交保单分期
+ (void)FenqiAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = FenqiAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///49.成为商铺信息
+ (void)UserShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = UserShop;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///50.申请成为商铺
+ (void)ShoptoShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ShoptoShop;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}
//51 已出账单/未出账单
+ (void)FenqimoneyWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Fenqimoney;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///52.保单详情
+ (void)BaodanDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaodanDetail;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///53.保单列表
+ (void)BaodanListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaodanList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///54.分期账单
+ (void)FenqiBillListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = FenqiBill;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///修改密码
+ (void)UserRestPwdWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = UserRestPwd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}


///意见反馈
+ (void)KefuAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = KefuAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

///成为代理
+ (void)ToAgentWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = ToAgent;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}



///确认收货
+ (void)IndentReceiveWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = IndentReceive;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///取消订单
+ (void)GetIndentCancelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = GetIndentCancel;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

///退货
+ (void)GetIndentReturnGoodslWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = IndentReturnGoods;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

//退款
+ (void)GetIndentReturnMoneylWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = IndentReturnMoney;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

//富文本
+ (void)GetCommonTextWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = CommonText;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

//个人首页信息
+ (void)GetUserhomeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = Userhome;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

//系统信息/客服电话
+ (void)GetAppVersionWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = AppVersion;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

//发表评论
+ (void)EvolutionAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = EvolutionAdd;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}


//取消预约
+ (void)CancelOrderWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = CancelOrder;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

//删除预约
+ (void)DelOrderWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = DelOrder;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


//BaoXianCartToubao
+ (void)BaoXianCartToubaoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoXianCartToubao;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}


+ (void)AdListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = AdList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

//1.获取用户车辆信息和去年投保信息
+ (void)BaoxianCarInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianCarInfo;
    [NewWorkingRequestManage requestSSPostWith:path parDic:dic finish:success error:failure];
}

//请求报价
+ (void)BaoxianPostPriceWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianPostPrice;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}

//获取报价
+ (void)BaoxianGetPriceWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianGetPrice;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}



+ (void)BaoxianHebaoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaoxianHebao;
    [NewWorkingRequestManage requestPostWith:path parDic:dic finish:success error:failure];
}



+ (void)QueryRecordListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = QueryRecordList;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}



+ (void)AgentInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = AgentInfo;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}


+ (void)BaojiaCountWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure {
    NSString *path = BaojiaCount;
    [NewWorkingRequestManage requestGetWith:path parDic:dic finish:success error:failure];
}

@end
