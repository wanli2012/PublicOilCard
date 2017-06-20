//
//  GLMine_SetController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_SetController.h"
#import "GLMine_SetCell.h"
#import "LBModifyPasswordViewController.h"
#import "GLRecommendController.h"

@interface GLMine_SetController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@end

@implementation GLMine_SetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_SetCell" bundle:nil] forCellReuseIdentifier:@"GLMine_SetCell"];
    _dataArr = @[@"密码修改",@"内存清理",@"关于公司",@"联系客服",@"版本更新"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
//退出登录
- (IBAction)quitLogin:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您确定要退出吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 10;
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        
        if (alertView.tag == 10) {
            
            [UserModel defaultUser].loginstatus = NO;
            [UserModel defaultUser].pic = @"";
            [UserModel defaultUser].group_id = @"0";
            [usermodelachivar achive];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshInterface" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if (alertView.tag == 11){
            
//            [self clearFile];//清楚缓存
        }
        
    }
    
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_SetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_SetCell"];
    cell.selectionStyle = 0;
    cell.titleLabel.text = _dataArr[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            self.hidesBottomBarWhenPushed = YES;
            LBModifyPasswordViewController *vc=[[LBModifyPasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            self.hidesBottomBarWhenPushed = YES;
            GLRecommendController *vc=[[GLRecommendController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }

}

@end
