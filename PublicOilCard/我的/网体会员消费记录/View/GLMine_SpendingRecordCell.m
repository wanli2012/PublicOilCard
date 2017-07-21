//
//  GLMine_SpendingRecordCell.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/7/20.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_SpendingRecordCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLMine_SpendingRecordCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsTypeLabel;

@end

@implementation GLMine_SpendingRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLMine_SpendingDetailModel *)model{
    _model = model;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.l_pic] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    self.moneyLabel.text = model.l_money;
    self.dateLabel.text = model.addtime;
    self.goodsTypeLabel.text = model.type;
}

@end
