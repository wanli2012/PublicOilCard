//
//  GLOpenSubordinateController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OpenController.h"

@interface GLMine_OpenController ()

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidth;

@end

@implementation GLMine_OpenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.getCodeBtn.layer.borderWidth = 1;
    self.getCodeBtn.layer.borderColor = TABBARTITLE_COLOR.CGColor;
    
    self.contentViewWidth.constant = SCREEN_WIDTH;
    self.contentViewHeight.constant = 300;
    
    self.navigationItem.title = @"开通下级";
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
//选择省市区
- (IBAction)chooseAddress:(id)sender {
    
}


@end
