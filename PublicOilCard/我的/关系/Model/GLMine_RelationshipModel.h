//
//  GLMine_RelationshipModel.h
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLMine_RelationshipModel : NSObject

@property (nonatomic, copy)NSString *IDNum;

@property (nonatomic, copy)NSString *name;

@property (nonatomic, copy)NSString *date;

@property (nonatomic, copy)NSString *subordinateNum;

@property (nonatomic, copy)NSString *memberNum;

@property (nonatomic, copy)NSString *firstDelegateNum;

@property (nonatomic, copy)NSString *secondDelegateNum;

@property (nonatomic, assign)BOOL isExpanded;

@end
