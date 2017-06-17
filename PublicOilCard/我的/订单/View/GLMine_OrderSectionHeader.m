//
//  GLMine_OrderSectionHeader.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OrderSectionHeader.h"

@interface GLMine_OrderSectionHeader()
@property (weak, nonatomic) IBOutlet UIButton *payNowBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation GLMine_OrderSectionHeader

- (void)awakeFromNib{
    [super awakeFromNib];
    self.payNowBtn.layer.cornerRadius = 5.f;
    self.payNowBtn.layer.borderWidth = 1;
    self.payNowBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
    
    self.cancelBtn.layer.cornerRadius = 5.f;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

@end
