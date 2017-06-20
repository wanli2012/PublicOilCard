//
//  LBMineCenterPayPagesViewController.h
//  Universialshare
//
//  Created by 四川三君科技有限公司 on 2017/4/21.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMineCenterPayPagesViewController : UIViewController

//@property (nonatomic, assign) NSInteger payType; // 支付类型 1普通消费支付  2 积分支付

@property (nonatomic, copy) NSString *order_id;//订单id

@property (nonatomic, copy) NSString *order_num;//订单号

@property (nonatomic, copy) NSString *addtime;//下单时间

@property (nonatomic, copy) NSString *realy_price;//支付金额


@property (nonatomic, copy)NSString *goods_id;

@property (nonatomic, copy)NSString *goods_num;

@end
