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

@property (weak, nonatomic) IBOutlet UITextField *oldTf;
@property (weak, nonatomic) IBOutlet UITextField *newaTf;
@property (weak, nonatomic) IBOutlet UITextField *repeatTf;


@end

@implementation LBModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    
}
//提交
- (IBAction)submitevent:(UIButton *)sender {
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
