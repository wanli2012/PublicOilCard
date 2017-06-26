//
//  GLMine_UploadController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/26.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_UploadController.h"
#import "GLMine_UploadRecordController.h"

@interface GLMine_UploadController ()

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *oilCardNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextF;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@end

@implementation GLMine_UploadController

- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"记录" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = 680;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (IBAction)submit:(id)sender {
    
}

- (void)record{
    
}
- (IBAction)record:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    GLMine_UploadRecordController *recordVC = [[GLMine_UploadRecordController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
