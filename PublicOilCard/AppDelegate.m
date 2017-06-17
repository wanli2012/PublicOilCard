//
//  AppDelegate.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "BasetabbarViewController.h"
#import "yindaotuViewController.h"
#import "GLLoginController.h"
#import "GLCompleteInfoController.h"
#import "LBMineCenterPayPagesViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[BasetabbarViewController alloc]init];
//    self.window.rootViewController = [[LBMineCenterPayPagesViewController alloc]init];
//    self.window.rootViewController = [[GLCompleteInfoController alloc]init];
//    self.window.rootViewController = [[GLLoginController alloc]init];
    
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isdirect1"] isEqualToString:@"YES"]) {
//        
//    }else{
//        self.window.rootViewController = [[yindaotuViewController alloc]init];
//    }
    
    return YES;
}

@end
