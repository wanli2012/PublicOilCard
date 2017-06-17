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
    
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgestureSection)];
    [self addGestureRecognizer:tapgesture];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}
- (void)setSectionModel:(GLMine_OrderSectionModel *)sectionModel{
    _sectionModel = sectionModel;
    
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单编号:%@", sectionModel.orderNum];
    self.dateLabel.text = [NSString stringWithFormat:@"创建时间:%@",sectionModel.orderDate];
    self.statusLabel.text = sectionModel.orderStatus;
    
}

-(void)tapgestureSection{
    self.sectionModel.isExpanded = !self.sectionModel.isExpanded;
    if (self.expandCallback) {
        self.expandCallback(self.sectionModel.isExpanded);
    }
}
@end
