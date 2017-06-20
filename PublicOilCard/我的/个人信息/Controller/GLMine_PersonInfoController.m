//
//  GLMine_PersonInfoController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_PersonInfoController.h"
#import "GLMine_PersonInfoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface GLMine_PersonInfoController ()<UITableViewDelegate,UITableViewDataSource>
{
    //假数据源
    NSArray *_keyArr;
    NSArray *_vlaueArr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic, strong)NSDictionary *dataDic;

@property (nonatomic, strong)NSMutableArray *canEditArr;

@end

@implementation GLMine_PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    
    _keyArr = @[@"头像",@"真实姓名",@"ID",@"二维码",@"身份证号码",@"银行卡号",@"开户银行",@"加油站自办芯片卡号",@"推荐人",@"推荐人ID"];
    
    _vlaueArr = @[[UserModel defaultUser].pic,
                  [UserModel defaultUser].truename,
                  [UserModel defaultUser].username,
                  [UserModel defaultUser].IDCard,
                  [UserModel defaultUser].pic,
                  [UserModel defaultUser].banknumber,
                  [UserModel defaultUser].openbank,
                  [UserModel defaultUser].jyzSelfCardNum,
                  [UserModel defaultUser].recommendUser,
                  [UserModel defaultUser].recommendID];
    self.tableViewHeight.constant = 8 * 40 + 2 * 60 + 30;
    
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn.titleLabel setTextAlignment:NSTextAlignmentRight];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_PersonInfoCell" bundle:nil] forCellReuseIdentifier:@"GLMine_PersonInfoCell"];
    [self getPersonInfo];
}
- (void)edit:(UIButton *)sender {
     sender.selected = !sender.selected;
    if(!sender.selected){
        
    }else{
        
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
        for (int i = 0; i < self.canEditArr.count; i ++) {
            if (i == 0 || i == 5 || i == 7) {
                [self.canEditArr replaceObjectAtIndex:i withObject:@YES];
            }
        }
    }
    
    [self.tableView reloadData];
}
- (void)getPersonInfo{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;
 
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/info_go" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
   
        if ([responseObject[@"code"] integerValue]==1) {
            self.dataDic = responseObject[@"data"];
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        [self.tableView reloadData];
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
        
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        return 8;
        
    }else{
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_PersonInfoCell"];
    cell.selectionStyle = 0;
    
    if (indexPath.section == 0) {
        
        cell.titleLabel.text = _keyArr[indexPath.row];
        cell.valueTF.text = _vlaueArr[indexPath.row];
        cell.valueTF.enabled = [self.canEditArr[indexPath.row] boolValue];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.picImageV.image = [UIImage imageNamed:_vlaueArr[indexPath.row]];
            cell.picImageV.userInteractionEnabled = [self.canEditArr[indexPath.row] boolValue];
            cell.picImageV.hidden = NO;

            cell.valueTF.hidden = YES;
            if (indexPath.row == 0) {
                cell.picImageV.layer.cornerRadius = cell.picImageV.width/2;
                
            }else{
                cell.picImageV.layer.cornerRadius = 0;
            }
        }else{
            
            cell.picImageV.hidden = YES;
            cell.valueTF.hidden = NO;
        }

    }else{
        cell.titleLabel.text = _keyArr[indexPath.row + 8];
        cell.valueTF.text = _vlaueArr[indexPath.row + 8];
        cell.valueTF.enabled = [self.canEditArr[indexPath.row + 8] boolValue];
        
        cell.picImageV.hidden = YES;
        cell.valueTF.hidden = NO;
        
    }
    
    if (cell.valueTF.enabled) {
        cell.valueTF.backgroundColor = [UIColor lightGrayColor];
    }else{
        cell.valueTF.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            return 60;
        }else{
            return 40;
        }
    }else{
        return 40;
    }
}
- (NSMutableArray *)canEditArr{
    if (!_canEditArr) {
        _canEditArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i ++) {
            [_canEditArr addObject:@NO];
        }
    }
    return _canEditArr;
}
@end
