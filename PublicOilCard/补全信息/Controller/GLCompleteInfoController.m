//
//  GLCompleteInfoController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLCompleteInfoController.h"

@interface GLCompleteInfoController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *IDTF;
@property (weak, nonatomic) IBOutlet UITextField *oilCardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *indentifierTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTF;

@end

@implementation GLCompleteInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"补全信息";
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
//省市区选择
- (IBAction)adressChoose:(id)sender {
    
}

//提交
- (IBAction)submit:(id)sender {
    if(self.nameTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入真实姓名"];
        return;
    }
    if(self.IDTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入全团ID号"];
        return;
    }
    if(self.oilCardNumTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入油卡卡号"];
        return;
    }
    if(self.indentifierTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入身份证号"];
        return;
    }
    if(self.bankCardNumTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入银行卡号"];
        return;
    }
    if(self.bankNameTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入银行名称"];
        return;
    }
    if(self.addressLabel.text.length <= 0){
        [MBProgressHUD showError:@"请选择省市区"];
        return;
    }
  
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.indentifierTF) {//身份证号只能输入数字和X
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890Xx"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            [MBProgressHUD showError:@"身份证号输入不合法"];
            return NO;
        }

    }else if(textField == self.IDTF){//ID号 只能输入数字和字母
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest){
            [MBProgressHUD showError:@"ID号输入不合法"];
            return NO;
        }
    }
    return YES;
    
}

@end
