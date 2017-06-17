//
//  GLMine_PersonInfoController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_PersonInfoController.h"
#import "GLMine_PersonInfoCell.h"

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

@end

@implementation GLMine_PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    
    _keyArr = @[@"头像",@"用户名",@"ID",@"二维码",@"身份证号码",@"推荐人",@"推荐人ID"];
    _vlaueArr = @[@"头像",@"吴秀波",@"123456",@"二维码",@"513021199919198837",@"胡歌",@"HG333"];
    self.tableViewHeight.constant = 5 * 40 + 2 * 60 + 30;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_PersonInfoCell" bundle:nil] forCellReuseIdentifier:@"GLMine_PersonInfoCell"];
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
        
        return 5;
        
    }else{
        
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_PersonInfoCell"];
    cell.selectionStyle = 0;
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = _keyArr[indexPath.row];
        cell.detailLabel.text= _vlaueArr[indexPath.row];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            
            cell.picImageV.hidden = NO;
            cell.detailLabel.hidden = YES;
            if (indexPath.row == 0) {
                cell.picImageV.layer.cornerRadius = cell.picImageV.width/2;
                
            }else{
                cell.picImageV.layer.cornerRadius = 0;
            }
        }else{
            
            cell.picImageV.hidden = YES;
            cell.detailLabel.hidden = NO;
        }
        
    }else{
        cell.titleLabel.text = _keyArr[indexPath.row + 5];
        cell.detailLabel.text= _vlaueArr[indexPath.row + 5];
        cell.picImageV.hidden = YES;
        cell.detailLabel.hidden = NO;
        
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
@end
