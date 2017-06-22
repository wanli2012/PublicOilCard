//
//  LBModifyPasswordViewController.m
//  PublicOilCard
//
//  Created by 四川三君科技有限公司 on 2017/6/19.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBModifyPasswordViewController.h"

@interface LBModifyPasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *oldView;
@property (weak, nonatomic) IBOutlet UIView *newaView;
@property (weak, nonatomic) IBOutlet UIView *repeatView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UITextField *oldTf;
@property (weak, nonatomic) IBOutlet UITextField *newaTf;
@property (weak, nonatomic) IBOutlet UITextField *repeatTf;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, assign)NSInteger page;//页数


@end

@implementation LBModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    
    self.submitBtn.layer.cornerRadius = 5.f;
    
}
//提交
- (IBAction)submitevent:(UIButton *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"new_pwd"] = self.newaTf.text;
    dict[@"old_pwd"] = self.oldTf.text;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/upd_pwd" paramDic:dict finish:^(id responseObject) {

        [_loadV removeloadview];
        
        [MBProgressHUD showError:responseObject[@"message"]];
        
        if ([responseObject[@"code"] integerValue] == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];

        [MBProgressHUD showError:error.localizedDescription];
    }];

    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField == self.oldTf && [string isEqualToString:@"\n"]) {
        [self.newaTf becomeFirstResponder];
        return NO;
    }else  if (textField == self.newaTf && [string isEqualToString:@"\n"]) {
        [self.repeatTf becomeFirstResponder];
        return NO;
    }else  if (textField == self.repeatTf && [string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }


    return YES;
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.oldView.layer.borderWidth = 1;
    self.oldView.layer.borderColor = YYSRGBColor(249, 56, 9, 1).CGColor;
    
    self.newaView.layer.borderWidth = 1;
    self.newaView.layer.borderColor = YYSRGBColor(249, 56, 9, 1).CGColor;
    
    self.repeatView.layer.borderWidth = 1;
    self.repeatView.layer.borderColor = YYSRGBColor(249, 56, 9, 1).CGColor;


}

@end
