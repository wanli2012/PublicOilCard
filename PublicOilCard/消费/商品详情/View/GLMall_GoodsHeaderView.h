//
//  GLMall_GoodsHeaderView.h
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@protocol GLMall_GoodsHeaderViewDelegate <NSObject>

- (void)changeNum:(NSString* )text;

@end

@interface GLMall_GoodsHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (nonatomic, copy)NSString * stockNum;

@property (nonatomic, assign)id<GLMall_GoodsHeaderViewDelegate> delegate;

@end
