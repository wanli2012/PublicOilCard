//
//  GLMine_UpdateManageController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OpenCardController.h"

@interface GLMine_OpenCardController ()
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation GLMine_OpenCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"升级管理";
    self.noticeLabel.text = @"首次纸卡费押金:200元/张首次纸卡费押金:200元/张\n首次纸卡费押金:200元/张";
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"物流" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(queryLog) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
//物流查询
- (void)queryLog{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

@end
