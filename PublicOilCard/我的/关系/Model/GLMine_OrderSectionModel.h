//
//  GLMine_OrderSectionModel.h
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLMine_OrderSectionModel : NSObject

@property (nonatomic, copy)NSString *orderNum;

@property (nonatomic, copy)NSString *orderDate;

@property (nonatomic, copy)NSString *orderStatus;


@property (nonatomic, assign)BOOL isExpanded;

@end
