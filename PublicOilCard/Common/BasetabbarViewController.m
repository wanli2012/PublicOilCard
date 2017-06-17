//
//  BasetabbarViewController.m
//  PovertyAlleviation
//
//  Created by 四川三君科技有限公司 on 2017/2/20.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

#import "BasetabbarViewController.h"
#import "BaseNavigationViewController.h"
#import "GLMallHomeController.h"
#import "GLMineHomeController.h"
#import "GLLoginController.h"

@interface BasetabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation BasetabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate=self;
    [self addViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(refreshInterface) name:@"refreshInterface" object:nil];
    
}

- (void)addViewControllers {
    
    //商城
    GLMallHomeController *mallVC = [[GLMallHomeController alloc] init];
    //个人中心
    GLMineHomeController *mineVC = [[GLMineHomeController alloc] init];
    
    BaseNavigationViewController *mallNav = [[BaseNavigationViewController alloc] initWithRootViewController:mallVC];
    BaseNavigationViewController *mineNav = [[BaseNavigationViewController alloc] initWithRootViewController:mineVC];
    
    mallNav.tabBarItem = [self barTitle:@"消费" image:@"首页未选中状态" selectImage:@"首页选中状态"];
    mineNav.tabBarItem = [self barTitle:@"我的" image:@"消费商城未选中状态" selectImage:@"消费商城"];
//    [UserModel defaultUser].usrtype = Retailer;
//    [UserModel defaultUser].loginstatus = YES;

//    [usermodelachivar achive];
//    if ([UserModel defaultUser].loginstatus == YES) {//登录状态
//        if ([[UserModel defaultUser].usrtype isEqualToString:ONESALER] || [[UserModel defaultUser].usrtype isEqualToString:TWOSALER]) {//一级业务员(副总) 二级业务员(高级推广员)
//            self.viewControllers = @[businessNav,ManAndBusinessNav, minenav];
//        }else if ([[UserModel defaultUser].usrtype isEqualToString:THREESALER]){//三级业务员(普通推广员)
//            self.viewControllers = @[businessNav, minenav];
//        }else if ([[UserModel defaultUser].usrtype isEqualToString:OrdinaryUser]){//普通用户
//            self.viewControllers = @[IntegralMallnav,nearbyNav, minenav];
//        }else if ([[UserModel defaultUser].usrtype isEqualToString:Retailer]){//商家
//            self.viewControllers = @[incomeNav,commentNav,storeNav, minenav];
//        }
//    }else{//退出状态
//        self.viewControllers = @[IntegralMallnav,nearbyNav, minenav];
//    }
    self.viewControllers = @[mallNav,mineNav];
    self.selectedIndex=0;
    
}

- (UITabBarItem *)barTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    UITabBarItem *item = [[UITabBarItem alloc] init];
    
    item.title = title;
    item.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : TABBARTITLE_COLOR} forState:UIControlStateSelected];
    item.titlePositionAdjustment = UIOffsetMake(0, -4);
    return item;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    
    int index;
//    if ([[UserModel defaultUser].usrtype isEqualToString:OrdinaryUser]) {
//        index = 2;
//    }else if ([[UserModel defaultUser].usrtype isEqualToString:Retailer]){
//        index = 3;
//    }else if ([[UserModel defaultUser].usrtype isEqualToString:@"0"] || [UserModel defaultUser].usrtype == nil || [[UserModel defaultUser].usrtype isEqualToString:ONESALER] || [[UserModel defaultUser].usrtype isEqualToString:TWOSALER]){
//        index = 2;
//    }else{
//        index = 1;
//    }
//    if (viewController == [tabBarController.viewControllers objectAtIndex:index]) {
//
//        if ([UserModel defaultUser].loginstatus == YES) {
//            
//            if ([[UserModel defaultUser].rzstatus isEqualToString:@"0"] || [[UserModel defaultUser].rzstatus isEqualToString:@"3"]) {
//                
//                LBImprovePersonalDataViewController *infoVC = [[LBImprovePersonalDataViewController alloc] init];
//                infoVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//                [self presentViewController:infoVC animated:YES completion:nil];
//                return NO;
//            }
//            return YES;
//        }
//        GLLoginController *loginVC = [[GLLoginController alloc] init];
//        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
//        nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        [self presentViewController:nav animated:YES completion:nil];
//        return NO;
//
//    }

    return YES;
}
//刷新界面
-(void)refreshInterface{
    
    [self.viewControllers reverseObjectEnumerator];
    
    [self addViewControllers];

}

- (void)pushToHome{
    
     self.selectedIndex = 0;
}

@end
