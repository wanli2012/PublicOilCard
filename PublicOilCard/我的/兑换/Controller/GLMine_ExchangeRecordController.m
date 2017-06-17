//
//  GLMine_ExchangeRecordController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_ExchangeRecordController.h"
#import "GLMine_ExchangeRecord_SuccessController.h"

@interface GLMine_ExchangeRecordController ()

@end

@implementation GLMine_ExchangeRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"兑换记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addviewcontrol];
    [self selectTagByIndex:0 animated:YES];
    
    self.hidesBottomBarWhenPushed=YES;

}
//重载init方法
- (instancetype)init
{
    if (self = [super initWithTagViewHeight:45])
    {
        
    }
    return self;
}
-(void)addviewcontrol{
    
    //设置自定义属性
    self.tagItemSize = CGSizeMake(SCREEN_WIDTH / 3, 45);
    
    NSArray *titleArray = @[
                            @"成功",
                            @"未审核",
                            @"失败",
                            ];
    
    NSArray *classNames = @[
                            [GLMine_ExchangeRecord_SuccessController class],
                            [GLMine_ExchangeRecord_SuccessController class],
                            [GLMine_ExchangeRecord_SuccessController class],
                            ];
    
    self.normalTitleColor = [UIColor blackColor];
    self.selectedTitleColor = TABBARTITLE_COLOR;
    self.selectedIndicatorColor = TABBARTITLE_COLOR;
    
    
    [self reloadDataWith:titleArray andSubViewdisplayClasses:classNames withParams:nil];
    
}
@end
