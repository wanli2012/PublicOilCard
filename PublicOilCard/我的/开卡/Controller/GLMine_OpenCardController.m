//
//  GLMine_UpdateManageController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OpenCardController.h"
#import "LBMineCenterPayPagesViewController.h"
#import "LBViewProtocolViewController.h"

@interface GLMine_OpenCardController ()
{
    LoadWaitView *_loadV;
}

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel2;
@property (weak, nonatomic) IBOutlet UIButton *openCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectedImageBtn;

@property (assign, nonatomic)BOOL isAgreel;//是否同意注册协议 默认为NO

@end

@implementation GLMine_OpenCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"我要开卡";
    
    self.isAgreel = YES;
    self.openCardBtn.userInteractionEnabled = YES;
    
    [self refresh];
}

- (void)refresh {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    
    _loadV = [LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:kREFRESH_URL paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        if ([responseObject[@"code"] integerValue]==1) {
            if ([responseObject[@"data"] count] != 0) {
                
                [UserModel defaultUser].cost = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"cost"]];
                [UserModel defaultUser].cost2 = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"cost2"]];
                [UserModel defaultUser].isHaveOilCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isHaveOilCard"]];
                [UserModel defaultUser].hua_status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"hua_status"]];
                [UserModel defaultUser].card_info = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"card_info"]];
                [UserModel defaultUser].card_money = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"card_money"]];
                
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].cost] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].cost = @"";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].cost2] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].cost2 = @"";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].isHaveOilCard] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].isHaveOilCard = @"0";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].hua_status] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].hua_status = @"0";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].card_info] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].card_info = @"0";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].card_money] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].card_money = @"0";
                }
                
                [usermodelachivar achive];
            }
            
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        
        if (self.type == 0) {
            
            self.noticeLabel.text = [NSString stringWithFormat:@"一次性服务费%@元+卡内%@元油费",[UserModel defaultUser].cost,[UserModel defaultUser].card_money];
            
        }else{
            
             self.noticeLabel.text = [NSString stringWithFormat:@"一次性服务费%@元+卡内%@元油费",[UserModel defaultUser].cost2,[UserModel defaultUser].card_money];

        }
        self.noticeLabel2.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].card_info];
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];
}

//是否同意协议
- (IBAction)isAgreeProtocol:(id)sender {
    self.isAgreel = !self.isAgreel;
    
    if (self.isAgreel) {
        self.openCardBtn.userInteractionEnabled = YES;
        self.openCardBtn.backgroundColor = TABBARTITLE_COLOR;
        [self.selectedImageBtn setImage:[UIImage imageNamed:@"注册协议选中"] forState:UIControlStateNormal];
    }else{
        self.openCardBtn.userInteractionEnabled = NO;
        self.openCardBtn.backgroundColor = [UIColor lightGrayColor];
        [self.selectedImageBtn setImage:[UIImage imageNamed:@"注册协议未选中"] forState:UIControlStateNormal];
    }
}
- (IBAction)protocol:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    LBViewProtocolViewController *vc=[[LBViewProtocolViewController alloc]init];
    vc.navTitle = @"开卡协议";
    vc.webUrl = kOPENCARD_DELEGATE_URL;
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)openCard:(id)sender {
    if (_isAgreel == NO) {
        [MBProgressHUD showError:@"未勾选注册协议"];
        return;
    }

    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterPayPagesViewController *pay = [[LBMineCenterPayPagesViewController alloc] init];
    pay.pushIndex = 2;
    pay.openCardType = self.type;
    [self.navigationController pushViewController:pay animated:YES];
}

@end
