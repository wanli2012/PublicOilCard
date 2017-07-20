//
//  GLMine_HeaderView.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_HeaderView.h"
#import <Masonry/Masonry.h>

@interface GLMine_HeaderView ()

@property (nonatomic, strong)UIImageView *levelImageV;

@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong)UIView *lineView2;

@property (nonatomic, strong)UIView *lineView3;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *picImageVHeight;

@end

@implementation GLMine_HeaderView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    _openCardBtn.layer.borderWidth = 1;
    _openCardBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
    
    _exchangeBtn.layer.borderWidth = 1;
    _exchangeBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
    
    self.picImageVHeight.constant = 80 *autoSizeScaleY;
    self.picImageV.contentMode = UIViewContentModeScaleAspectFill;
    self.picImageV.layer.cornerRadius = self.picImageVHeight.constant /2;

    self.IDLabel.font = [UIFont systemFontOfSize:11 * autoSizeScaleY];
    self.nameLabel.font = [UIFont systemFontOfSize:11 * autoSizeScaleY];

    [self.openCardBtn.titleLabel setFont:[UIFont systemFontOfSize:12 * autoSizeScaleY]];
    [self.exchangeBtn.titleLabel setFont:[UIFont systemFontOfSize:12 * autoSizeScaleY]];
}

@end
