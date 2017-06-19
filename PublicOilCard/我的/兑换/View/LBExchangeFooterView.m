//
//  LBExchangeFooterView.m
//  PublicOilCard
//
//  Created by 四川三君科技有限公司 on 2017/6/19.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBExchangeFooterView.h"
#import <Masonry/Masonry.h>

@implementation LBExchangeFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadUI];
        
        self.backgroundColor=YYSRGBColor(235, 235, 235, 1);
    }
    return self;
    
}

-(void)loadUI{

    [self addSubview:self.namelebel];
    [self addSubview:self.infoLabel];
    
    [self.namelebel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(0);
        make.leading.equalTo(self).offset(0);
        make.top.equalTo(self).offset(20);
        make.height.equalTo(@20);
    }];

}

-(UILabel*)infoLabel{
    
    if (!_infoLabel) {
        _infoLabel=[[UILabel alloc]init];
        _infoLabel.backgroundColor=YYSRGBColor(239, 239, 239, 1);
        _infoLabel.textColor=YYSRGBColor(50, 50, 50, 1);
        _infoLabel.font=[UIFont systemFontOfSize:12 ];
        _infoLabel.textAlignment=NSTextAlignmentCenter;
        _infoLabel.numberOfLines=0;
        [_infoLabel sizeToFit];
    }
    return _infoLabel;
    
}

-(UILabel*)namelebel{
    
    if (!_namelebel) {
        _namelebel=[[UILabel alloc]init];
        _namelebel.backgroundColor=[UIColor clearColor];
        _namelebel.textColor=YYSRGBColor(50, 50, 50, 1);
        _namelebel.font=[UIFont systemFontOfSize:14];
        _namelebel.textAlignment=NSTextAlignmentCenter;
       _namelebel.text = @"会员须知";
    }
    return _namelebel;
    
}


@end
