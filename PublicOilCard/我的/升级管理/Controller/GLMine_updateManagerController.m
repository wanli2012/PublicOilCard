//
//  GLMine_updateManagerController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_updateManagerController.h"
#import "GLMine_updateManagerModel.h"
//#import "GLMine_updateManagerCell.h"
//#import "GLMine_updateManagerAllCell.h"
//#import "GLMine_updateManagerDealNowCell.h"
#import "GLMine_updateNewCell.h"
#import "LBMineCenterPayPagesViewController.h"

@interface GLMine_updateManagerController ()<UITableViewDelegate,UITableViewDataSource,GLMine_updateNewCellDelegate>
{
    //假数据源
    NSArray *_keyArr;
    NSMutableArray *_tempArr;
    BOOL _isCheckAll;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *tempArr;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, assign)NSInteger page;//页数

@property (nonatomic, copy)NSString *status;//审核状态  0未审核 1审核成功  2审核失败
@property (nonatomic, copy)NSString *upgrade;//升级类型 1首期代理   2二期代理

@end

@implementation GLMine_updateManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"升级管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerAllCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerAllCell"];
//    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerDealNowCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerDealNowCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateNewCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateNewCell"];
    
    _keyArr = @[@"赠送6000积分送6000积分送6000积分送6000积分送6000积分",
                @"用户赠送6000积分送6000积分送6000积分送6000积分送6000积分名",
                @"I赠送6000积分送6000积分送6000积分送6000积分送6000积分D",
                @"二维赠送6000积分送6000积分送6000积分送6000积分送6000积分码",
                @"身份证赠送6000积分送6000积分送6000积分送6000积分送6000积分号码",
                @"推赠送6000积分送6000积分送6000积分送6000积分送6000积分荐人",
                @"推荐人ID"];


    [self.tableView addSubview:self.nodataV];
    self.nodataV.hidden = YES;
    
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf updateData:YES];
        
    }];
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf updateData:NO];
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    }];
    
    // 设置文字
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    self.tableView.mj_footer = footer;
    
    [self updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    if (status) {
        
        self.page = 1;
        [self.models removeAllObjects];
        
    }else{
        _page ++;
        
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"page"] = [NSString stringWithFormat:@"%zd",self.page];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/upgrade_user" paramDic:dict finish:^(id responseObject) {
        [self endRefresh];
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {
            //判空以及赋值
            if ([responseObject[@"data"][@"msg"] isEqual:[NSNull null]]) {
                self.dataArr = @[];
            }else{
                
                self.dataArr = responseObject[@"data"][@"msg"];
            }
            if ([responseObject[@"data"][@"status"] isEqual:[NSNull null]]) {
                self.status = @"";
            }else{
                
                self.status = responseObject[@"data"][@"status"];
            }
            if ([responseObject[@"data"][@"upgrade"] isEqual:[NSNull null]]) {
                self.upgrade = @"";
            }else{
                
                self.upgrade = responseObject[@"data"][@"upgrade"];
            }
            
            if ([responseObject[@"data"] count] == 0 && self.dataArr.count != 0) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [self endRefresh];
        [MBProgressHUD showError:error.localizedDescription];
    }];
    
}
- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114-49);
    }
    return _nodataV;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma GLMine_updateNewDelegate
//开通代理商
- (void)open:(NSInteger)index{
    
    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterPayPagesViewController *pay = [[LBMineCenterPayPagesViewController alloc] init];
    if (index == 0) {
        if([self.status integerValue] == 0){
            [MBProgressHUD showError:@"首期代理资格正在审核中"];
        }else if([self.status integerValue] == 1){
            [MBProgressHUD showError:@"已开通首期代理"];
        }else{
            
            pay.upgrade = 1;
        }
       
    }else{
        pay.upgrade = 2;
     
    }
    pay.pushIndex = 3;//表示从升级管理跳转的
    
    [self.navigationController pushViewController:pay animated:YES];

}

#pragma UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(self.dataArr.count == 0){
        self.nodataV.hidden = NO;
    }else{
        self.nodataV.hidden =YES;
    }
    
    return self.dataArr.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMine_updateNewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateNewCell"];
    cell.titleLabel.text = self.dataArr[indexPath.row][@"title"];
    cell.contentLabel.text = self.dataArr[indexPath.row][@"right"];
    cell.delegate = self;
    cell.index = indexPath.row;
    cell.selectionStyle = 0;

//    [self statusEnsure:indexPath];
    switch ([self.status integerValue]) {
        case 0://未审核
        {
            if(([self.upgrade integerValue] - 1) == indexPath.row){
                
                [cell.openBtn setTitle:@"审核中" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                
            }else{
                [cell.openBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            cell.openBtn.enabled = NO;
            
        }
            break;
        case 1://审核成功
        {
            if(([self.upgrade integerValue] - 1) == indexPath.row){
                
                [cell.openBtn setTitle:@"已办理" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }else{
                [cell.openBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            }
            cell.openBtn.enabled = NO;
        }
            break;
        case 2://审核失败
        {
            if(([self.upgrade integerValue] - 1) == indexPath.row){
                
                [cell.openBtn setTitle:@"重新开通" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:TABBARTITLE_COLOR forState:UIControlStateNormal];
            }else{
                [cell.openBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                [cell.openBtn setTitleColor:TABBARTITLE_COLOR forState:UIControlStateNormal];
            }
            cell.openBtn.enabled = YES;
            
        }
            break;
        default:
            break;
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    return self.tableView.rowHeight;
}

- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

@end
