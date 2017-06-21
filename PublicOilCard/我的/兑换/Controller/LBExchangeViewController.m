//
//  LBExchangeViewController.m
//  PublicOilCard
//
//  Created by 四川三君科技有限公司 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBExchangeViewController.h"
#import "LBExchangeHeaderView.h"
#import "LBChooseTypeTableViewCell.h"
#import "LBWriteInfoTableViewCell.h"
#import "LBExchangeJiFenTableViewCell.h"
#import "IncentiveModel.h"
#import "LBExchangeFooterView.h"
#import "GLMine_ExchangeRecordController.h"

@interface LBExchangeViewController ()<UITableViewDelegate,UITableViewDataSource,IncentiveModelDelegete,LBExchangeJiFenTableViewCellDelegete>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic)LBExchangeHeaderView *exchangeHeaderView;
@property (strong, nonatomic)LBExchangeFooterView *exchangeFooterView;
@property (strong, nonatomic)IncentiveModel *incentiveModelV;
@property (strong, nonatomic)IncentiveModel *incentiveModelVT;//到账方式
@property (strong, nonatomic)IncentiveModel *incentiveModelVE;//兑换方式
@property (strong, nonatomic)UIView *incentiveModelMaskV;
@property (assign, nonatomic)NSInteger selectindex;//判断是否是团购账号或银行卡 1为团购 0为银行卡
@property (strong, nonatomic)NSArray *arr;//全团账号 信息
@property (strong, nonatomic)NSArray *arr2;//银行卡 信息
@property (strong, nonatomic)NSArray *arr3;//兑换信息
@property (strong, nonatomic)NSArray *curetarr;

@property (strong, nonatomic)NSArray *typeArr;//卡分类
@property (strong, nonatomic)NSArray *mothodArr;//到账方式

@property (strong, nonatomic)NSString *typeStr;//账号类型
@property (strong, nonatomic)NSString *mothodStr;//到账方式
@property (strong, nonatomic)NSString *Exchangestr;//兑换方式

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, assign)NSInteger page;//页数

@end

@implementation LBExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"兑换";
    self.typeStr = self.typeArr[0];
    self.mothodStr = self.mothodArr[0];
    self.Exchangestr = self.arr3[0];
    self.selectindex = 1;
    /**
     *设置tableview 的HeaderView
     */
    self.exchangeHeaderView = [[NSBundle mainBundle]loadNibNamed:@"LBExchangeHeaderView" owner:self options:nil].firstObject;
    self.exchangeHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 250 * autoSizeScaleY);
    self.tableview.tableHeaderView = self.exchangeHeaderView;
    //赋值
    self.exchangeHeaderView.jifenLb.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].mark];
    self.exchangeHeaderView.yuELb.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].yue];
    if ([self.exchangeHeaderView.jifenLb.text rangeOfString:@"null"].location != NSNotFound) {
        self.exchangeHeaderView.jifenLb.text = @"0.00";
    }
    if ([self.exchangeHeaderView.yuELb.text rangeOfString:@"null"].location != NSNotFound) {
        self.exchangeHeaderView.yuELb.text = @"0.00";
    }

    /**
     *设置tableview 的FooterView
     */
    self.exchangeFooterView = [[LBExchangeFooterView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    self.tableview.tableFooterView = self.exchangeFooterView;
    /**
     *注册cell
     */
      [self.tableview registerNib:[UINib nibWithNibName:@"LBChooseTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBChooseTypeTableViewCell"];
      [self.tableview registerNib:[UINib nibWithNibName:@"LBWriteInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBWriteInfoTableViewCell"];
      [self.tableview registerNib:[UINib nibWithNibName:@"LBExchangeJiFenTableViewCell" bundle:nil] forCellReuseIdentifier:@"LBExchangeJiFenTableViewCell"];
    /**
     *incentiveModelMaskV 添加手势
     */
    UITapGestureRecognizer *incentiveModelMaskVgesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(incentiveModelMaskVtapgestureLb)];
    [self.incentiveModelMaskV addGestureRecognizer:incentiveModelMaskVgesture];
    
    /**
     *兑换记录
     */
    //自定义导航栏右键
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 14, 60, 30);
    [rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [rightBtn setTitle:@"兑换记录" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn addTarget:self  action:@selector(recommendRecord) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self postRequest];
}
- (void)postRequest {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/sel_user" paramDic:dict finish:^(id responseObject) {
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {

            self.dataDic = responseObject[@"data"];
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        [self.tableview reloadData];
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden= NO;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.selectindex == 1) {
        _curetarr = self.arr ;
    }else{
        _curetarr = self.arr2;
    }
    
    return _curetarr.count + 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return 50;
    }else if (indexPath.row > 0 && indexPath.row <_curetarr.count + 1) {
         return 50;
    }else if (indexPath.row == _curetarr.count + 1) {
         return 80;
    }else if (indexPath.row == _curetarr.count + 2) {
         return 80;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
            LBChooseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBChooseTypeTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
         cell.bottomConstrait.constant = 1;
         cell.topConstrait.constant = 0;
        cell.subTitle.hidden = YES;
        /**
         *根据选择展示不同信息
         */
        
        cell.titleLb.text = self.typeStr;
       
          return cell;
    }else if (indexPath.row  >0 && indexPath.row <_curetarr.count + 1) {
        LBWriteInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBWriteInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textf.placeholder = _curetarr [indexPath.row - 1];
        cell.textf.textColor = [UIColor darkGrayColor];
        
        if (self.selectindex == 1) {
            cell.textf.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].qtIdNum];
        }else{
            cell.textf.text = [NSString stringWithFormat:@"%@",[UserModel defaultUser].qtIdNum];
        }
        
        return cell;
    }else if (indexPath.row == _curetarr.count + 1) {
        LBChooseTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBChooseTypeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bottomConstrait.constant = 10;
        cell.topConstrait.constant = 10;
        cell.subTitle.hidden = NO;
        cell.titleLb.text = @"到账方式";
        cell.subTitle.text = self.mothodStr;
        
        return cell;
    }else if (indexPath.row == _curetarr.count + 2) {
        LBExchangeJiFenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LBExchangeJiFenTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegete = self;
        cell.titleLb.text = self.Exchangestr;
        cell.indexpath = indexPath;
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
        
        self.incentiveModelV.frame=CGRectMake(SCREEN_WIDTH-130, rect.origin.y+20, 120, 80);
        [self.view addSubview:self.incentiveModelMaskV];
        [self.incentiveModelMaskV addSubview:self.incentiveModelV];
        
    }else  if (indexPath.row == _curetarr.count + 1) {
        CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
        CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
        
        self.incentiveModelVT.frame=CGRectMake(SCREEN_WIDTH-130, rect.origin.y+20, 120, 120);
        [self.view addSubview:self.incentiveModelMaskV];
        [self.incentiveModelMaskV addSubview:self.incentiveModelVT];
        
    }

}
#pragma mark - 点击全团账号或银行卡

-(void)choosebutton:(NSInteger)tag typeIndex:(NSInteger)typeIndex{

    if (typeIndex == 1) {
        if (tag == 10) {
            self.selectindex = 1;
        }else if (tag == 11){
            self.selectindex = 0
        ;
        }
        
        self.typeStr = self.typeArr [tag - 10];

    }else if (typeIndex ==2){
    
        self.mothodStr = self.mothodArr [tag - 10];
    
    }else if (typeIndex ==3){
        
        self.Exchangestr = self.arr3 [tag - 10];
        
    }
    
    [self.tableview reloadData];
    [self incentiveModelMaskVtapgestureLb];
    
}

//点击maskview
-(void)incentiveModelMaskVtapgestureLb{
    
        [self.incentiveModelMaskV removeFromSuperview];
        [self.incentiveModelV removeFromSuperview];
        [self.incentiveModelVT removeFromSuperview];
        [self.incentiveModelVE removeFromSuperview];
}
//兑换记录
-(void)recommendRecord{
    self.hidesBottomBarWhenPushed = YES;
    GLMine_ExchangeRecordController *vc=[[GLMine_ExchangeRecordController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark --- LBExchangeJiFenTableViewCellDelegete

-(void)showExchangeType:(NSIndexPath *)indexpath{

    CGRect rectInTableView = [self.tableview rectForRowAtIndexPath:indexpath];
    CGRect rect = [self.tableview convertRect:rectInTableView toView:[self.tableview superview]];
    
    self.incentiveModelVE.frame=CGRectMake(30, rect.origin.y+20, 120, 80);
    [self.view addSubview:self.incentiveModelMaskV];
    [self.incentiveModelMaskV addSubview:self.incentiveModelVE];
}

-(IncentiveModel*)incentiveModelV{
    
    if (!_incentiveModelV) {
        
        _incentiveModelV = [[IncentiveModel alloc]initWithFrame:CGRectMake(0, 0, 120, 80) buttonArr:self.typeArr];
        _incentiveModelV.delegete = self;
        _incentiveModelV.typeIndex = 1;
    }
    
    return _incentiveModelV;
    
}

-(IncentiveModel*)incentiveModelVT{
    
    if (!_incentiveModelVT) {
        
        _incentiveModelVT = [[IncentiveModel alloc]initWithFrame:CGRectMake(0, 0, 120, 120) buttonArr:self.mothodArr];
        _incentiveModelVT.delegete = self;
        _incentiveModelVT.typeIndex = 2;
    }
    
    return _incentiveModelVT;
    
}

-(IncentiveModel*)incentiveModelVE{
    
    if (!_incentiveModelVE) {
        
        _incentiveModelVE = [[IncentiveModel alloc]initWithFrame:CGRectMake(0, 0, 120, 80) buttonArr:self.arr3];
        _incentiveModelVE.delegete = self;
        _incentiveModelVE.typeIndex = 3;
    }
    
    return _incentiveModelVE;
    
}

-(UIView*)incentiveModelMaskV{
    
    if (!_incentiveModelMaskV) {
        _incentiveModelMaskV=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _incentiveModelMaskV.backgroundColor=[UIColor clearColor];
    }
    
    return _incentiveModelMaskV;
    
}

-(NSArray*)arr{

    if (!_arr) {
        _arr = [NSArray arrayWithObjects:@"无全团账号", nil];
    }

    return _arr;

}

-(NSArray*)arr2{
    
    if (!_arr2) {
        
        _arr2 = [NSArray arrayWithObjects:@"没有绑定银行卡", nil];
    }
    
    return _arr2;
    
}

-(NSArray*)arr3{
    
    if (!_arr3) {
        
        _arr3 = [NSArray arrayWithObjects:@"兑换积分",@"兑换余额",nil];
    }
    
    return _arr3;
    
}
-(NSDictionary*)dataDic{
    
    if (!_dataDic) {
        
        _dataDic = [NSDictionary dictionary];
    }
    
    return _dataDic;
    
}
-(NSArray*)typeArr{
    
    if (!_typeArr) {
        _typeArr = [NSArray arrayWithObjects:@"全团账号",@"银行卡", nil];
    }
    
    return _typeArr;
    
}
-(NSArray*)mothodArr{
    
    if (!_mothodArr) {
        _mothodArr = [NSArray arrayWithObjects:@"T + 1",@" T + 3",@"T + 7", nil];
    }
    
    return _mothodArr;
    
}
@end
