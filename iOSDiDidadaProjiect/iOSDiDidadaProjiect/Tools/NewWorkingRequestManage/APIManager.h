//
//  APIManager.h
//  IOSStockProject
//
//  Created by 程磊 on 2017/6/17.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject



///1. 登录
+ (void)LogonWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///2. 注册
+ (void)RegisterWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///3. 获取验证码
+ (void)GetCodeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///4.商品列表
+ (void)GetGoodsListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///5. 商品详情
+ (void)GetGoodsDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///6. 商品分类列表
+ (void)GetGoodsTypelistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///7. 添加购物车
+ (void)ShopcartaddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///8. 修改购物车 post
+ (void)ShopcarteditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///9. 删除购物车
+ (void)ShopcartdelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


///10. 清空购物车
+ (void)ShopcartdelAllWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


///11. 购物车列表
+ (void)ShopcartlistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///12. 添加收货地址
+ (void)AddressaddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


///13. 修改地址
+ (void)AddresseditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///14. 收货地址列表
+ (void)AddresslistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///15. 删除收货地址 get
+ (void)AddressdelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///16. 获取默认收货地址
+ (void)AddressdefaultWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///17. 附近商家
+ (void)GetNearShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///18. 文章列表
+ (void)GetArticleWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;
///19. 平台分类列表
+ (void)GetShopTypeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///20. 平台商品列表
+ (void)GetShopGoodslistWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///21. 评论列表
+ (void)GetGetEvolutionListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///22. 预约列表
+ (void)GetGetMyOrderListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///23. 预约
+ (void)DoOrderAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///24. 修改个人资料
+ (void)DoUserEditWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///25. 修改个人资料
+ (void)GetUserFreshWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///26. 获取车辆列表
+ (void)GetGetCarListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///27. 添加车辆
+ (void)DoCarAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///28. 删除车辆
+ (void)DoCarDeleteWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///29. 文章详情
+ (void)GetArticleDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///30. 购物车id 生成订单
+ (void)GetIndentAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;
///31. 商品id 生成订单
+ (void)GetAddByGoodsWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///32. 订单列表
+ (void)GetIndentListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


///33. 违章城市列表
+ (void)WeizhangCityListListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


///34.保险省份列表
+ (void)BaoxianProvinceListListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///35.保险城市列表
//+ (void)BaoxianCityListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///36.险别查询
+ (void)BaoxianRisksListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///37. 违章查询
+ (void)WeizhangInfoListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///38. 车型列表
+ (void)BaoxianCarmodeoListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///39. 车辆信息
+ (void)BaoxianCarinfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///40. 删除订单
+ (void)GetIndentdeleteWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///41. 订单详情
+ (void)GetIndentDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///42. 物流信息
+ (void)ExpressInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///43. 轮播图
+ (void)BannerListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///44. 发布 ArticleAdd
+ (void)ArticleAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///45. 地区支持的保险公司
+ (void)BaoxianInsurerListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///46. 保险参考报价
+ (void)BaoxianCankaoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///47. 保险精准报价
+ (void)BaoxianBaojiaWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///48.提交保单分期
+ (void)FenqiAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///49.成为商铺信息
+ (void)UserShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///50.申请成为商铺
+ (void)ShoptoShopWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//51 已出账单/未出账单
+ (void)FenqimoneyWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///52.保单详情
+ (void)BaodanDetailWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///53.保单列表
+ (void)BaodanListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///54.分期账单
+ (void)FenqiBillListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///55.修改密码
+ (void)UserRestPwdWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///56.意见反馈
+ (void)KefuAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;
    
///57.成为代理
+ (void)ToAgentWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///57.确认收货
+ (void)IndentReceiveWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///58.取消订单
+ (void)GetIndentCancelWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///59.申请退货
+ (void)GetIndentReturnGoodslWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///60.申请退款
+ (void)GetIndentReturnMoneylWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

///61.富文本
+ (void)GetCommonTextWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//个人首页信息
+ (void)GetUserhomeWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//系统信息/客服电话
+ (void)GetAppVersionWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//发表评论
+ (void)EvolutionAddWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//取消预约
+ (void)CancelOrderWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//删除预约
+ (void)DelOrderWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//保险起期
+ (void)BaoXianCartToubaoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//类型
+ (void)AdListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;



//1.获取用户车辆信息和去年投保信息
+ (void)BaoxianCarInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


//请求报价
+ (void)BaoxianPostPriceWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

//获取报价
+ (void)BaoxianGetPriceWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;
//核保
+ (void)BaoxianHebaoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;


+ (void)QueryRecordListWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

+ (void)AgentInfoWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

+ (void)BaojiaCountWithParameters:(NSMutableDictionary *)dic success:(void(^)(id data))success  failure:(void (^)( NSError *error))failure;

@end
