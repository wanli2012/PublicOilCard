//
//  GLMine_OrderSectionHeader.h
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLMine_OrderSectionModel.h"

typedef void(^OrderHeadViewExpandCallback)(BOOL isExpanded);
@interface GLMine_OrderSectionHeader : UITableViewHeaderFooterView

@property (nonatomic, copy)OrderHeadViewExpandCallback expandCallback;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong)GLMine_OrderSectionModel *sectionModel;

@end
