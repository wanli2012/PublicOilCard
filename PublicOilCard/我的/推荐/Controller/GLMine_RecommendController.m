//
//  GLMine_RecommendController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_RecommendController.h"
#import "GLMine_RecommendRecordController.h"

@interface GLMine_RecommendController ()

@property (weak, nonatomic) IBOutlet UIImageView *codeImageV;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation GLMine_RecommendController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"推荐";
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    self.noticeLabel.text = @"注意事项\n推广权益";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)record {
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_RecommendRecordController *recordVC = [[GLMine_RecommendRecordController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
@end
