//
//  Header.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/3/23.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define timea 0.3f

#define YYSRGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define TABBARTITLE_COLOR YYSRGBColor(255, 80, 0 , 1.0) //导航栏颜色
#define autoSizeScaleX (SCREEN_WIDTH/320.f)
#define autoSizeScaleY (SCREEN_HEIGHT/568.f)

#define ADAPT(x) SCREEN_WIDTH / 375 *(x)

///接口
//119.23.213.255  http://api.51qmtg.org/index.php/App/  http://www.51qmtg.org/index.php/app/
#define URL_Base @"http://api.51qmtg.org/index.php/app/"
//#define URL_Base @"http://192.168.0.190/CARD/index.php/app/"

#define kLOGIN_URL @"User/login" //登录

#define kREGISTER_URL @"User/register" //注册

#define kGET_CODE_URL @"User/get_yzm" //获取验证码

#define kGET_CITYLIST_URL @"User/getCityList" //城市列表

#define kREFRESH_URL @"User/refresh" //刷新

#define kINFO_BQ @"User/userInfoBq" //信息补全

#define kSHOP_Main_URL  @"ShopInfo/shop_index"//商城首页

#define kSHOP_DETAIL_URL @"ShopInfo/goods_info"//商品详情

#define kSHOP_BUYNOW_URL @"ShopInfo/buy_order"//立即购买

#define kSHOP_DEL_COLLECT_URL @"UserInfo/del_collect"//删除收藏

#define kSHOP_ADD_COLLECT_URL @"UserInfo/collec_add"//添加收藏

#define kSHOPINFO_UPLOAD_URL @"ShopInfo/app_order_line"//上传凭证

#define kSHOPINFO_ORDERLIST_URL @"ShopInfo/line_list"//凭证列表

#define kMODIFY_INFO_URL @"UserInfo/user_info_in"//修改个人信息

#define kUPLOADPIC_URL @"UserInfo/save_picture"//上传图片

#define kUPDATEPWD_URL @"UserInfo/upd_pwd"//修改密码

#define kDELEGATEINFO_URL @"UserInfo/upgrade_user"//升级个人代理界面信息

#define kEXCHANGE_URL @"UserInfo/back_operate"//兑换接口

#define kEXCHANGELIST_URL @"UserInfo/mark_list"//兑换记录列表

#define kINFOLIST_URL @"User/msg_list"//消息列表

#define kCOLLECTEIONLIST_URL @"UserInfo/collec_list"//收藏列表

#define kORDERLIST_URL @"UserInfo/order_list"//订单列表

#define kDEL_ORDER_URL @"UserInfo/del_order"//删除订单

#define kCANCEL_ORDER_URL @"UserInfo/cancel_order"//取消定单

#define kRECOMMENDLIST_URL @"UserInfo/groom_list"//推荐列表

#define kOPEN_UNDER_URL @"UserInfo/open_under"//开同下级

#define kRELATIONSHIPLIST_URL @"UserInfo/bz_groom_list"//关系 列表

#define kORDER_PAY_URL @"ShopInfo/order_pay"//订单支付

#define kOPENCARD_URL @"UserInfo/operate_card"//开卡

#define kUPGRADE_URL @"UserInfo/upgrade"//升级成个代


//下载地址
#define DOWNLOAD_URL @"https://itunes.apple.com/cn/app/id1228047806?mt=8"
//获取appStore上的最新版本号地址
#define GET_VERSION  @"https://itunes.apple.com/lookup?id=1228047806"
//关于公司网址
#define ABOUTUS_URL @"http://www.51qmtg.org/youka/about.html"
//注册协议
#define REGISTER_URL @"http://www.51qmtg.org/youka/agreement.html"
//开卡协议
#define kOPENCARD_URL @"https://www.baidu.com"
//公告
#define NOTICE_URL @"https://www.51dztg.com/index.php/Home/Newsdemo/newestnotice.html"

//个人代理 首期代理
#define Retailer @"4"
//会员
#define OrdinaryUser @"6"
//二期代理
#define TWODELEGATE @"5"
////首期代理
//#define ONEDELEGATE @"4"
//经理
#define MANAGER @"3"
//总监
#define DIRECTOR @"2"
//部长
#define MINISTER @"1"

#define PlaceHolderImage @"picnodata"
#define LUNBO_PlaceHolder @"轮播占位图"
#define kGOODS_PlaceHolder @"产品占位图"

//http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html
//分享
#define SHARE_URL @"http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html?mod=member&act=register&username="
#define UMSHARE_APPKEY @"58cf31dcf29d982906001f63"
//微信分享
#define WEIXI_APPKEY @"wxf482af02a200da8e"
#define WEIXI_SECRET @"487532cd8355a7ae06f44d5abe2486ba"
//微博分享
#define WEIBO_APPKEY @"3040295141"
#define WEIBO_SECRET @"3e3728b874c9f207cefb043cf418e6a4"
//友盟分享 AppKey
#define USHARE_DEMO_APPKEY @"594b286765b6d607f3000f9a"

//虚拟货币名称
#define NormalMoney @"米子"
#define SpecialMoney @"推荐米子"
//公钥RSA
#define public_RSA @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDF4IeiOMGVERr/4oTZWuthQx+eesKBx70SH5xPavN8s07rFbPf3VQ8yhqsX2TuBhsVz5PDjFyn3NgfJPXr5uVCSu3nONGttK3pnYsIlkHLOQAq3uDl3UwvuDnz6j7Urjxkkonh011o8FZ5pGMSSmGkMVyJ8RVTUIKgcQhNk4VXwIDAQAB"

#define NMUBERS @"0123456789./*-+~!@#$%^&()_+-=,./;'[]{}:<>?`"


#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

/**
 * 物流地址
 */

#define logisticsUrl @"http://jisukdcx.market.alicloudapi.com/express/query"

//3%返利的宏
#define KThreePersent @"4"

//支付宝appid
#define AlipayAPPID @"2017061907523362"

#endif /* Header_h */
