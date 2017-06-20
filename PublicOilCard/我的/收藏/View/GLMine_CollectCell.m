//
//  GLMine_CollectCell.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_CollectCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLMine_CollectCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation GLMine_CollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GLMine_CollectModel *)model{
    _model = model;
    [self.picImageV sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:PlaceHolderImage]];
    self.titleLabel.text = model.goods_name;
    self.detailLabel.text = model.goods_info;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.discount];
    
}
@end
