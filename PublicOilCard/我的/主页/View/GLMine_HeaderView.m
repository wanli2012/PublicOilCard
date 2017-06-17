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

@end

@implementation GLMine_HeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       [self loadUI];
        self.backgroundColor = YYSRGBColor(249, 250, 251, 1);
        self.picImagaV.layer.cornerRadius = self.picImagaV.width/2;
        self.picImagaV.clipsToBounds = YES;
    }
    return self;
    
}
-(void)loadUI{
    [self addSubview:self.picImagaV];
    [self addSubview:self.levelImageV];
    [self addSubview:self.positionLabel];
    [self addSubview:self.IDLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.openCardBtn];
    [self addSubview:self.exchangeBtn];
    
    [self addSubview:self.adImageV];
    [self addSubview:self.middleView];

    [self.middleView addSubview:self.xiaofeiView];
    [self.middleView addSubview:self.jifenView];
    [self.middleView addSubview:self.tuijianView];
    
   
    [self.xiaofeiView addSubview:self.xiaofeiLabel];
    [self.xiaofeiView addSubview:self.xiaofeiL];
    
    [self.jifenView addSubview:self.jifenLabel];
    [self.jifenView addSubview:self.jifenL];
    
    [self.tuijianView addSubview:self.tuijianLabel];
    [self.tuijianView addSubview:self.tuijianL];

    [self.middleView addSubview:self.lineView];
    [self.middleView addSubview:self.lineView2];
    
//    [self addSubview:self.cycleScrollView];
    [self.levelImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.picImagaV).offset(0);
        make.centerY.equalTo(self.picImagaV.mas_bottom).offset(0);
        
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.picImagaV).offset(0);
        make.top.equalTo(self.picImagaV.mas_bottom).offset(5);
        
        make.width.equalTo(self.picImagaV);
        make.height.equalTo(self.picImagaV).offset(-60);
    }];
    [self.IDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.picImagaV).offset(0);
        make.top.equalTo(self.positionLabel.mas_bottom).offset(5);
       
        make.width.equalTo(self.picImagaV);
        make.height.equalTo(self.picImagaV).offset(-60);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.picImagaV).offset(0);
        make.top.equalTo(self.IDLabel.mas_bottom).offset(5);
        make.width.equalTo(self.picImagaV).offset(0);
        make.height.equalTo(self.IDLabel);

    }];
    
    [self.openCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
        
    }];
    
    [self.exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.trailing.equalTo(self).offset(-10);
        make.top.equalTo(self.openCardBtn.mas_bottom).offset(10);
        make.width.equalTo(self.openCardBtn);
        make.height.equalTo(self.openCardBtn);
        
    }];
    
    [UserModel defaultUser].usrtype = @"2";
    
    [self.adImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        
        
        if ([[UserModel defaultUser].usrtype integerValue] == 1) {
            
            make.height.equalTo(@0);
            
        }else{
            
            make.height.equalTo(self.picImagaV).offset(-20);
        }
        
    }];

    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.adImageV.mas_top).offset(0);
    
    }];

    [self.xiaofeiView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.top.equalTo(self.middleView).offset(0);
        make.bottom.equalTo(self.middleView).offset(0);
        
        
    }];

    [self.jifenView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.xiaofeiView.mas_trailing).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.top.equalTo(self.middleView).offset(0);
        make.bottom.equalTo(self.middleView).offset(0);
        
        
    }];
//
    [self.tuijianView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.jifenView.mas_trailing).offset(0);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.top.equalTo(self.middleView).offset(0);
        make.bottom.equalTo(self.middleView).offset(0);
        
        
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(5);
        make.bottom.equalTo(self.middleView).offset(-5);
        make.leading.equalTo(self.xiaofeiView.mas_trailing).offset(0);
        make.width.equalTo(@1);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(5);
        make.bottom.equalTo(self.middleView).offset(-5);
        make.leading.equalTo(self.jifenView.mas_trailing).offset(0);
        make.width.equalTo(@1);
    }];
    
    [self.xiaofeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.xiaofeiView).offset(10);
        make.trailing.equalTo(self.xiaofeiView).offset(-10);
        make.top.equalTo(self.xiaofeiView).offset(0);
        make.height.equalTo(@(20));
    
    }];
    
    [self.xiaofeiL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.xiaofeiView).offset(10);
        make.trailing.equalTo(self.xiaofeiView).offset(-10);
        make.top.equalTo(self.xiaofeiLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.xiaofeiView);
        
    }];
    
    [self.jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.jifenView).offset(10);
        make.trailing.equalTo(self.jifenView).offset(-10);
        make.top.equalTo(self.jifenView).offset(0);
        make.height.equalTo(self.xiaofeiLabel);
        
    }];
    
    [self.jifenL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.jifenView).offset(10);
        make.trailing.equalTo(self.jifenView).offset(-10);
        make.top.equalTo(self.jifenLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.jifenView);

    }];
    
    [self.tuijianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.tuijianView).offset(10);
        make.trailing.equalTo(self.tuijianView).offset(-10);
        make.top.equalTo(self.tuijianView).offset(0);
        make.height.equalTo(self.xiaofeiLabel);

        
    }];
    [self.tuijianL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.tuijianView).offset(10);
        make.trailing.equalTo(self.tuijianView).offset(-10);
        make.top.equalTo(self.tuijianLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.tuijianView);
 
    }];
    
    
//    [self.CollectinGoodsBt verticalCenterImageAndTitle:10];
//    [self.ShoppingCartBt verticalCenterImageAndTitle:10];
//    [self.OrderBt verticalCenterImageAndTitle:10];
//    
//    [self.picImagaV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[UserModel defaultUser].headPic]]];
    
    if (!self.picImagaV.image) {
        
        self.picImagaV.image = [UIImage imageNamed:@"dtx_icon"];
    }
    
//    self.nameLabel.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].name];
    
    if (self.nameLabel.text.length <= 0) {
        
        self.nameLabel.text = @"用户名";
    }
    self.IDLabel.text = @"ID:123445";
    self.xiaofeiLabel.text = @"2000元";
    self.jifenLabel.text = @"2000分";
    self.tuijianLabel.text = @"200人";
    self.xiaofeiL.text = @"消费";
    self.jifenL.text = @"全团积分";
    self.tuijianL.text = @"推荐";
    [self.openCardBtn setTitle:@"开卡" forState:UIControlStateNormal];
    [self.exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];

}

#pragma 懒加载
- (UIImageView *)picImagaV{
    if (!_picImagaV) {
        _picImagaV = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 10, 80, 80)];
        _picImagaV.backgroundColor = [UIColor grayColor];
        _picImagaV.userInteractionEnabled = YES;
    }
    return _picImagaV;
}
- (UIImageView *)levelImageV{
    if (!_levelImageV) {
        _levelImageV = [[UIImageView alloc] init];
        _levelImageV.backgroundColor = [UIColor orangeColor];
    }
    return _levelImageV;
}
- (UIButton *)openCardBtn{
    if (!_openCardBtn) {
        _openCardBtn = [[UIButton alloc] init];
        _openCardBtn.layer.borderWidth = 1;
        _openCardBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
//        _openCardBtn.layer.cornerRadius = 5.f;
        _openCardBtn.clipsToBounds = YES;
        [_openCardBtn setTitleColor:TABBARTITLE_COLOR forState:UIControlStateNormal];
        [_openCardBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
    }
    return _openCardBtn;
}
- (UIButton *)exchangeBtn{
    if (!_exchangeBtn) {
        _exchangeBtn = [[UIButton alloc] init];

        _exchangeBtn.layer.borderWidth = 1;
        _exchangeBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
//        _exchangeBtn.layer.cornerRadius = 5.f;
        _exchangeBtn.clipsToBounds = YES;
        [_exchangeBtn setTitleColor:TABBARTITLE_COLOR forState:UIControlStateNormal];
        [_exchangeBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];

    }
    return _exchangeBtn;
}
- (UILabel *)positionLabel{
    if (!_positionLabel) {
        _positionLabel = [[UILabel alloc] init];
        _positionLabel.textAlignment = NSTextAlignmentCenter;
        _positionLabel.backgroundColor=[UIColor clearColor];
        _positionLabel.textColor=[UIColor blackColor];
        _positionLabel.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _positionLabel.numberOfLines=0;
        [_positionLabel sizeToFit];
        
    }
    return _positionLabel;
}
- (UILabel *)IDLabel{
    if (!_IDLabel) {
        _IDLabel = [[UILabel alloc] init];
        _IDLabel.textAlignment = NSTextAlignmentCenter;
        _IDLabel.backgroundColor=[UIColor clearColor];
        _IDLabel.textColor=[UIColor blackColor];
        _IDLabel.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _IDLabel.numberOfLines=0;
        [_IDLabel sizeToFit];

    }
    return _IDLabel;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor=[UIColor clearColor];
        _nameLabel.textColor=[UIColor blackColor];
        _nameLabel.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
        _nameLabel.numberOfLines=0;
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc] init];
       
    }
    return _middleView;
}
- (UIView *)xiaofeiView{
    if (!_xiaofeiView) {
        _xiaofeiView = [[UIView alloc] init];
        
    }
    return _xiaofeiView;
}
- (UIView *)jifenView{
    if (!_jifenView) {
        _jifenView = [[UIView alloc] init];
        
    }
    return _jifenView;
}
- (UIView *)tuijianView{
    if (!_tuijianView) {
        _tuijianView = [[UIView alloc] init];
       
    }
    return _tuijianView;
}

- (UILabel *)xiaofeiLabel{
    if (!_xiaofeiLabel) {
        _xiaofeiLabel = [[UILabel alloc] init];
        _xiaofeiLabel.textAlignment = NSTextAlignmentCenter;
        _xiaofeiLabel.backgroundColor=[UIColor clearColor];
        _xiaofeiLabel.textColor=[UIColor blackColor];
        _xiaofeiLabel.font=[UIFont systemFontOfSize:13 * autoSizeScaleX];
        _xiaofeiLabel.textAlignment=NSTextAlignmentCenter;
        _xiaofeiLabel.numberOfLines=0;
        [_xiaofeiLabel sizeToFit];
    }
    return _xiaofeiLabel;
}
- (UILabel *)xiaofeiL{
    if (!_xiaofeiL) {
        _xiaofeiL = [[UILabel alloc] init];
        _xiaofeiL.textAlignment = NSTextAlignmentCenter;
        _xiaofeiL.backgroundColor=[UIColor clearColor];
        _xiaofeiL.textColor=[UIColor darkGrayColor];
        _xiaofeiL.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _xiaofeiL.textAlignment=NSTextAlignmentCenter;
        _xiaofeiL.numberOfLines=0;
        [_xiaofeiL sizeToFit];
    }
    return _xiaofeiL;
}
- (UILabel *)jifenLabel{
    if (!_jifenLabel) {
        _jifenLabel = [[UILabel alloc] init];
        _jifenLabel.textAlignment = NSTextAlignmentCenter;
        _jifenLabel.backgroundColor=[UIColor clearColor];
        _jifenLabel.textColor=[UIColor blackColor];
        _jifenLabel.font=[UIFont systemFontOfSize:13 * autoSizeScaleX];
        _jifenLabel.textAlignment=NSTextAlignmentCenter;
        _jifenLabel.numberOfLines=0;
        [_jifenLabel sizeToFit];
    }
    return _jifenLabel;
}
- (UILabel *)jifenL{
    if (!_jifenL) {
        _jifenL = [[UILabel alloc] init];
        _jifenL.textAlignment = NSTextAlignmentCenter;
        _jifenL.backgroundColor=[UIColor clearColor];
        _jifenL.textColor=[UIColor darkGrayColor];
        _jifenL.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _jifenL.textAlignment=NSTextAlignmentCenter;
        _jifenL.numberOfLines=0;
        [_jifenL sizeToFit];
    }
    return _jifenL;
}
- (UILabel *)tuijianLabel{
    if (!_tuijianLabel) {
        _tuijianLabel = [[UILabel alloc] init];
        _tuijianLabel.textAlignment = NSTextAlignmentCenter;
        _tuijianLabel.backgroundColor=[UIColor clearColor];
        _tuijianLabel.textColor=[UIColor blackColor];
        _tuijianLabel.font=[UIFont systemFontOfSize:13 * autoSizeScaleX];
        _tuijianLabel.textAlignment=NSTextAlignmentCenter;
        _tuijianLabel.numberOfLines=0;
        [_tuijianLabel sizeToFit];
    }
    return _tuijianLabel;
}
- (UILabel *)tuijianL{
    if (!_tuijianL) {
        _tuijianL = [[UILabel alloc] init];
        _tuijianL.textAlignment = NSTextAlignmentCenter;
        _tuijianL.backgroundColor=[UIColor clearColor];
        _tuijianL.textColor=[UIColor darkGrayColor];
        _tuijianL.font=[UIFont systemFontOfSize:12 * autoSizeScaleX];
        _tuijianL.textAlignment=NSTextAlignmentCenter;
        _tuijianL.numberOfLines=0;
        [_tuijianL sizeToFit];
    }
    return _tuijianL;
}
- (UIImageView *)adImageV{
    if (!_adImageV) {
        _adImageV = [[UIImageView alloc] init];
        _adImageV.backgroundColor = [UIColor redColor];
    }
    return _adImageV;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        _lineView.alpha = 0.3;
    }
    return _lineView;
}
- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor lightGrayColor];
        _lineView2.alpha = 0.3;
    }
    return _lineView2;
}
@end
