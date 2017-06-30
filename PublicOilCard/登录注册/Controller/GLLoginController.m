
//  GLLoginController.m
//  Universialshare
//
//  Created by 龚磊 on 2017/4/5.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "GLLoginController.h"
#import "GLRegisterController.h"
#import "BasetabbarViewController.h"
#import "LoginIdentityView.h"
#import "LBHomeLoginFortgetSecretViewController.h"
#import "BaseNavigationViewController.h"
#import "GLMineHomeController.h"
#import "GLCompleteInfoController.h"

@interface GLLoginController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *scretTf;

@property (strong, nonatomic)LoginIdentityView *loginView;
@property (strong, nonatomic)UIImageView *currentloginViewimage;//当前选择身份的选中图

@property (strong, nonatomic)UIView *maskView;
@property (strong, nonatomic)NSString *usertype;//用户类型 默认为善行者
@property (strong, nonatomic)LoadWaitView *loadV;

@end

@implementation GLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.bgView.layer.shadowOpacity = 0.7;//阴影透明度，默认0
    self.bgView.layer.shadowRadius = 5;//阴影半径，默认3
    
    [self.loginView.cancelBt addTarget:self action:@selector(maskviewgesture) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.sureBt addTarget:self action:@selector(surebuttonEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *maskvgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(maskviewgesture)];
    [self.maskView addGestureRecognizer:maskvgesture];
    //选择会员
    UITapGestureRecognizer *shanVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shangViewgesture)];
    [self.loginView.shangView addGestureRecognizer:shanVgesture];
    //个人代理
    UITapGestureRecognizer *lingVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lingViewgesture)];
    [self.loginView.lingView addGestureRecognizer:lingVgesture];
    //选择经理
    UITapGestureRecognizer *ThreeVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(threeSalerViewgesture)];
    [self.loginView.oneView addGestureRecognizer:ThreeVgesture];
   
    //总监
    UITapGestureRecognizer *fourVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourSalerViewgesture)];
    [self.loginView.twoView addGestureRecognizer:fourVgesture];
    //部长
    UITapGestureRecognizer *fiveVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fiveSalerViewgesture)];
    [self.loginView.threeView addGestureRecognizer:fiveVgesture];
    
    self.currentloginViewimage = self.loginView.shangImage;
    
//    CAGradientLayer *layer = [CAGradientLayer new];
//    //colors存放渐变的颜色的数组
//    layer.colors=@[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)TABBARTITLE_COLOR.CGColor,(__bridge id)[UIColor whiteColor].CGColor];
//    layer.startPoint = CGPointMake(0.5, 0);
//    layer.endPoint = CGPointMake(0.5, 1);
//    layer.frame = self.loginBtn.bounds;
//    [self.loginBtn.layer addSublayer:layer];
//    
//    CAGradientLayer *layera = [CAGradientLayer new];
//    //colors存放渐变的颜色的数组
//    layera.colors=@[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)YYSRGBColor(198, 51, 14, 1).CGColor,(__bridge id)[UIColor whiteColor].CGColor];
//    layera.startPoint = CGPointMake(0.5, 0);
//    layera.endPoint = CGPointMake(0.5, 1);
//    layera.frame = self.registerBtn.bounds;
//    [self.registerBtn.layer addSublayer:layera];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.usertype = OrdinaryUser;

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
//注册
- (IBAction)registerClick:(id)sender {
    [self.view endEditing:YES];
    GLRegisterController *registerVC = [[GLRegisterController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

//登录
- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];
    if (self.phone.text.length <=0 ) {
        [MBProgressHUD showError:@"请输入手机号码或ID"];
        return;
    }
    
    if (self.scretTf.text.length <= 0) {
        [MBProgressHUD showError:@"密码不能为空"];
        return;
    }
    
    if (self.scretTf.text.length < 6 || self.scretTf.text.length > 20) {
        [MBProgressHUD showError:@"请输入6-20位密码"];
        return;
    }
    
    [self.view addSubview:self.maskView];
    [self.view addSubview:self.loginView];
    self.loginView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loginView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:nil];
    
}
//隐藏或显示图片
- (IBAction)showOrHide:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.scretTf setSecureTextEntry:NO];
        [sender setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
        
    }else{
        [self.scretTf setSecureTextEntry:YES];
        [sender setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
    }
}
//退出
- (IBAction)exitLoginEvent:(UIButton *)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
//忘记密码
- (IBAction)forgetButtonEvent:(UIButton *)sender {

    LBHomeLoginFortgetSecretViewController *vc=[[LBHomeLoginFortgetSecretViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

//确定按
-(void)surebuttonEvent{
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
 
    [NetworkManager requestPOSTWithURLStr:@"user/login" paramDic:@{@"userphone":self.phone.text,@"password":self.scretTf.text,@"groupID":self.usertype} finish:^(id responseObject) {

        [_loadV removeloadview];
        if ([responseObject[@"code"] integerValue] == 1 && ![responseObject[@"data"] isEqual:[NSNull null]]) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
                
                [UserModel defaultUser].pic = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"pic"]];
                [UserModel defaultUser].username = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"username"]];
                [UserModel defaultUser].truename = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"truename"]];
                [UserModel defaultUser].IDCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"IDCard"]];
                [UserModel defaultUser].phone = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"phone"]];
                [UserModel defaultUser].address = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"address"]];
                [UserModel defaultUser].recommendUser = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"recommendUser"]];
                [UserModel defaultUser].recommendID = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"recommendID"]];
                [UserModel defaultUser].price = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]];
                [UserModel defaultUser].mark = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"mark"]];
                [UserModel defaultUser].recNumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"recNumber"]];
                [UserModel defaultUser].banknumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"banknumber"]];
                [UserModel defaultUser].group_id = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"group_id"]];
                [UserModel defaultUser].group_name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"group_name"]];
                [UserModel defaultUser].openbank = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"openbank"]];
                [UserModel defaultUser].version = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"version"]];
                [UserModel defaultUser].qtIdNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"qtIdNum"]];
                [UserModel defaultUser].isBqInfo = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isBqInfo"]];
                [UserModel defaultUser].isHaveNewMsg = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isHaveNewMsg"]];
                [UserModel defaultUser].isHaveOilCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isHaveOilCard"]];
                [UserModel defaultUser].token = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"token"]];
                [UserModel defaultUser].uid = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"uid"]];
                
                [UserModel defaultUser].loginstatus = YES;
                [UserModel defaultUser].yue = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"yue"]];
                [UserModel defaultUser].jyzSelfCardNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"jyzSelfCardNum"]];
                [UserModel defaultUser].qtIdNum = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"qtIdNum"]];
                
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].banknumber] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].banknumber = @"";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].openbank] rangeOfString:@"null"].location != NSNotFound) {
                    [UserModel defaultUser].openbank = @"";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].jyzSelfCardNum] rangeOfString:@"null"].location != NSNotFound) {
                    
                    [UserModel defaultUser].jyzSelfCardNum = @"";
                }
                if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].qtIdNum] rangeOfString:@"null"].location != NSNotFound || [UserModel defaultUser].qtIdNum == nil) {
                    
                    [UserModel defaultUser].qtIdNum = @"";
                }
                
                [usermodelachivar achive];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshInterface" object:nil];
            
            if ([[UserModel defaultUser].group_id isEqualToString:MANAGER] || [[UserModel defaultUser].group_id isEqualToString:DIRECTOR]|| [[UserModel defaultUser].group_id isEqualToString:MINISTER]){
                
//                GLMineHomeController *homevc = [[GLMineHomeController alloc] init];
//                BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:homevc];
//                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                
                if ([UserModel defaultUser].loginstatus == YES) {

                    if ([[UserModel defaultUser].isBqInfo integerValue] == 0) {

                        GLCompleteInfoController *infoVC = [[GLCompleteInfoController alloc] init];
                        infoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        [self presentViewController:infoVC animated:YES completion:nil];
                    }

                }
                GLMineHomeController *homevc = [[GLMineHomeController alloc] init];
                BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:homevc];
                nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                [self presentViewController:nav animated:YES completion:nil];

            }else{
                
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
}

//普通用户
-(void)shangViewgesture{
    
    self.usertype = OrdinaryUser;
    if (self.currentloginViewimage == self.loginView.shangImage) {
        return;
    }
    self.loginView.shangImage.image=[UIImage imageNamed:@"登录选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"登录未选中"];
    self.currentloginViewimage = self.loginView.shangImage;
}
//个人代理
-(void)lingViewgesture{
    
    self.usertype = Retailer;
    if (self.currentloginViewimage == self.loginView.lingimage) {
        return;
    }
    self.loginView.lingimage.image=[UIImage imageNamed:@"登录选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"登录未选中"];
    self.currentloginViewimage = self.loginView.lingimage;
    
}

//经理
-(void)threeSalerViewgesture{
    
    self.usertype = MANAGER;
    if (self.currentloginViewimage == self.loginView.oneImage) {
        return;
    }
    self.loginView.oneImage.image=[UIImage imageNamed:@"登录选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"登录未选中"];
    self.currentloginViewimage = self.loginView.oneImage;
    
}
//总监
-(void)fourSalerViewgesture{
    
    self.usertype = DIRECTOR;
    if (self.currentloginViewimage == self.loginView.twoImage) {
        return;
    }
    self.loginView.twoImage.image=[UIImage imageNamed:@"登录选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"登录未选中"];
    self.currentloginViewimage = self.loginView.twoImage;
    
}
//部长
-(void)fiveSalerViewgesture{
    
    self.usertype = MINISTER;
    if (self.currentloginViewimage == self.loginView.threeImage) {
        return;
    }
    self.loginView.threeImage.image=[UIImage imageNamed:@"登录选中"];
    self.currentloginViewimage.image=[UIImage imageNamed:@"登录未选中"];
    self.currentloginViewimage = self.loginView.threeImage;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == self.phone && [string isEqualToString:@"\n"]) {
        [self.scretTf becomeFirstResponder];
        return NO;
        
    }else if (textField == self.scretTf && [string isEqualToString:@"\n"]){
        
        [self.view endEditing:YES];
        return NO;
    }
    
    if (textField == self.phone ) {
        
        for(int i=0; i< [string length];i++){
            
            int a = [string characterAtIndex:i];
            
            if( a >= 0x4e00 && a <= 0x9fff)
                
                return NO;
        }
    }
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    
}

//点击maskview
-(void)maskviewgesture{
    
    [self.maskView removeFromSuperview];
    [self.loginView removeFromSuperview];
    
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.clipsToBounds = YES;
    self.registerBtn.layer.cornerRadius = 4;
    self.registerBtn.clipsToBounds = YES;
    
    self.loginView.sureBt.layer.cornerRadius = 4;
    self.loginView.sureBt.clipsToBounds = YES;
    self.loginView.cancelBt.layer.cornerRadius = 4;
    self.loginView.cancelBt.clipsToBounds = YES;


}

-(LoginIdentityView*)loginView{
   
    CGFloat loginViewHeight = 300;
    if (!_loginView) {
        
        _loginView=[[NSBundle mainBundle]loadNibNamed:@"LoginIdentityView" owner:self options:nil].firstObject;
        _loginView.frame=CGRectMake(20, (SCREEN_HEIGHT - loginViewHeight)/2, SCREEN_WIDTH-40, loginViewHeight);
        _loginView.alpha=1;
        
    }
    
    return _loginView;
    
}

-(UIView*)maskView{
    
    if (!_maskView) {
        _maskView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [_maskView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.0f]];
        
    }
    return _maskView;
    
}

@end
