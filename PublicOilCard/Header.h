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

#define URL_Base @"http://www.51qmtg.org/index.php/app/"
//#define URL_Base @"http://192.168.0.190/CARD/index.php/app/"
//下载地址
#define DOWNLOAD_URL @"https://itunes.apple.com/cn/app/id1228047806?mt=8"
//关于公司网址
#define ABOUTUS_URL @"http://www.51qmtg.org/youka/about.html"
//注册协议
#define REGISTER_URL @"http://www.51qmtg.org/youka/agreement.html"
//开卡协议
#define kOPENCARD_URL @"https://www.baidu.com"
//公告
#define NOTICE_URL @"https://www.51dztg.com/index.php/Home/Newsdemo/newestnotice.html"

//个人代理
#define Retailer @"4"
//会员
#define OrdinaryUser @"6"
////二期代理
//#define TWODELEGATE @"5"
////首期代理
//#define ONEDELEGATE @"4"
//经理
#define MANAGER @"3"
//总监
#define DIRECTOR @"2"
//部长
#define MINISTER @"1"

#define PlaceHolderImage @"picnodata"
#define LUNBO_PlaceHolder @"轮播暂位图"
#define MERCHAT_PlaceHolder @"商户暂位图"

//http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html
//分享
#define SHARE_URL @"http://dzgx.joshuaweb.cn/index.php/Home/Regist/index.html?mod=member&act=register&username="
#define UMSHARE_APPKEY @"58cf31dcf29d982906001f63"
//微信分享
#define WEIXI_APPKEY @"wxf482af02a200da8e"
#define WEIXI_SECRET @"487532cd8355a7ae06f44d5abe2486ba"
//微博分享
#define WEIBO_APPKEY @"2203958313"
#define WEIBO_SECRET @"9a911777f4b18555cd2b42a9bc186389"
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
