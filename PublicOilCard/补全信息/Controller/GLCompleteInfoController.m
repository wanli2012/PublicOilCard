//
//  GLCompleteInfoController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLCompleteInfoController.h"
#import "GLLoginController.h"
#import "BaseNavigationViewController.h"
#import "LBMineCenterChooseAreaViewController.h"
#import "editorMaskPresentationController.h"

@interface GLCompleteInfoController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>
{
    BOOL _ishidecotr;//判断是否隐藏弹出控制器
}

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *IDTF;
@property (weak, nonatomic) IBOutlet UITextField *oilCardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *indentifierTF;
@property (weak, nonatomic) IBOutlet UITextField *bankCardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *bankNameTF;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@property (strong, nonatomic)NSString *status;//判断登录是否过期
@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic, strong)NSMutableArray *dataArr;
//保存省市区
@property (strong, nonatomic)NSString *provinceStrId;
@property (strong, nonatomic)NSString *cityStrId;
@property (strong, nonatomic)NSString *countryStrId;

@end

@implementation GLCompleteInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"补全信息";
    [self getCityList];
}
- (void)getCityList {
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:[UIApplication sharedApplication].keyWindow];
    [NetworkManager requestPOSTWithURLStr:@"user/getCityList" paramDic:@{} finish:^(id responseObject) {
        [_loadV removeloadview];
        if ([responseObject[@"code"] integerValue]==1) {
            self.dataArr = responseObject[@"data"];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
//省市区选择
- (IBAction)adressChoose:(id)sender {
    
    LBMineCenterChooseAreaViewController *vc=[[LBMineCenterChooseAreaViewController alloc]init];
    vc.dataArr = self.dataArr;
    vc.transitioningDelegate=self;
    vc.modalPresentationStyle=UIModalPresentationCustom;
    
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof(self) weakself = self;
    vc.returnreslut = ^(NSString *str,NSString *strid,NSString *provinceid,NSString *cityd,NSString *areaid){
        weakself.addressLabel.textColor = [UIColor blackColor];
        weakself.addressLabel.text = str;
        weakself.provinceStrId = provinceid;
        weakself.cityStrId = cityd;
        weakself.countryStrId = areaid;
    };
}

//退出
- (IBAction)exit:(id)sender {
    
    if ([self.status isEqualToString:@"1"]) {
        
        GLLoginController *loginVC = [[GLLoginController alloc] init];
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nav animated:YES completion:nil];
        
    }else{
    
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

//提交
- (IBAction)submit:(id)sender {
    if(self.nameTF.text.length <= 0){
        [MBProgressHUD showError:@"请输入真实姓名"];
        return;
    }
//    if(self.IDTF.text.length <= 0){
//        [MBProgressHUD showError:@"请输入全团ID号"];
//        return;
//    }
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
    if([self.addressLabel.text isEqualToString:@"请选择省市区"]){
        [MBProgressHUD showError:@"请选择省市区"];
        return;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"truename"] = self.nameTF.text;
    dict[@"province"] = self.provinceStrId;
    dict[@"city"] = self.cityStrId;
    dict[@"area"] = self.countryStrId;
    dict[@"qtIdNum"] = self.IDTF.text;
    dict[@"jyzSelfCardNum"] = self.oilCardNumTF.text;
    dict[@"IDCard"] = self.indentifierTF.text;
  
    dict[@"banknumber"] = self.bankCardNumTF.text;
    dict[@"openbank"] = self.bankNameTF.text;


    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    //     NSString *encryptsecret = [RSAEncryptor encryptString:self.scretTf.text publicKey:public_RSA];
    //    NSLog(@"%@",encryptsecret);
    
    [NetworkManager requestPOSTWithURLStr:@"user/userInfoBq" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue] == 0) {
            self.status = @"1";
            [self.exitBtn setTitle:@"重新登录" forState:UIControlStateNormal];
        }
        if ([responseObject[@"code"] integerValue]==1) {
            
            [MBProgressHUD showError:responseObject[@"message"]];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            [UserModel defaultUser].isBqInfo = @"1";
            
            [usermodelachivar achive];

        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
  
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
#pragma 动画要用到的代理
//动画
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    
    return [[editorMaskPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    
}
//控制器创建执行的动画（返回一个实现UIViewControllerAnimatedTransitioning协议的类）
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _ishidecotr=YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _ishidecotr=NO;
    return self;
}
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 0.5;
    
}
-(void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    [self chooseAddress:transitionContext];

}
//选择省市区
-(void)chooseAddress:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    if (_ishidecotr==YES) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame=CGRectMake(-SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
        toView.layer.cornerRadius = 6;
        toView.clipsToBounds = YES;
        [transitionContext.containerView addSubview:toView];
        [UIView animateWithDuration:0.3 animations:^{
            
            toView.frame=CGRectMake(20, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
            
        }];
    }else{
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            toView.frame=CGRectMake(20 + SCREEN_WIDTH, (SCREEN_HEIGHT - 300)/2, SCREEN_WIDTH - 40, 280);
            
        } completion:^(BOOL finished) {
            if (finished) {
                [toView removeFromSuperview];
                [transitionContext completeTransition:YES]; //这个必须写,否则程序 认为动画还在执行中,会导致展示完界面后,无法处理用户的点击事件
            }
            
        }];
        
    }
    
}
#pragma 懒加载
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
