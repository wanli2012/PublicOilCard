//
//  GLMine_UpdateManageController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OpenCardController.h"
#import "LBMineCenterPayPagesViewController.h"

@interface GLMine_OpenCardController ()
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@end

@implementation GLMine_OpenCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"升级管理";
    //自定义右键
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"物流" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [btn addTarget:self  action:@selector(queryLog) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(0, 0, 80, 40);
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [self refresh];
}
- (void)refresh {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
    [NetworkManager requestPOSTWithURLStr:@"user/refresh" paramDic:dict finish:^(id responseObject) {
        
        if ([responseObject[@"code"] integerValue]==1) {
            [UserModel defaultUser].cost = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"cost"]];
         
        if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].cost] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].cost = @"";
            }
          
            [usermodelachivar achive];
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        self.noticeLabel.text = [NSString stringWithFormat:@"首次制卡费押金:%@元/张\n一次性永久服务费",[UserModel defaultUser].cost];
        
    } enError:^(NSError *error) {
        
        [MBProgressHUD showError:error.localizedDescription];
    }];
}
//物流查询
- (void)queryLog{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)openCard:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterPayPagesViewController *pay = [[LBMineCenterPayPagesViewController alloc] init];
    pay.pushIndex = 2;
    [self.navigationController pushViewController:pay animated:YES];
}

@end
