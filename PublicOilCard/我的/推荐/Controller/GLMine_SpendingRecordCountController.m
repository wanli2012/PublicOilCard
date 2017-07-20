//
//  GLMine_SpendingRecordDetailController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/7/20.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_SpendingRecordCountController.h"
//#import "GLMine_SpendingRecordCell.h"
#import "GLMine_SpendingCountModel.h"
#import "GLMine_RecommendRecordCell.h"
#import "GLMine_SpendingDetailController.h"

@interface GLMine_SpendingRecordCountController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, assign)NSInteger page;//页数

@end

@implementation GLMine_SpendingRecordCountController

- (instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        self = [[GLMine_SpendingRecordCountController alloc] init];
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
 
    [self initTableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_RecommendRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_RecommendRecordCell"];
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
- (void)initTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)updateData:(BOOL)status {
    if (status) {
        
        self.page = 1;
        [self.models removeAllObjects];
        
    }else{
        _page ++;
        
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"page"] = [NSString stringWithFormat:@"%zd",self.page];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"type"] = [NSString stringWithFormat:@"%zd",self.type];
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:kCOUNT_URL paramDic:dict finish:^(id responseObject) {
        
        [self endRefresh];
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {
            if ([responseObject[@"data"] count] != 0) {
                for (NSDictionary *dict in responseObject[@"data"]) {
                    
                    GLMine_SpendingCountModel * model = [GLMine_SpendingCountModel mj_objectWithKeyValues:dict];
                    [self.models addObject:model];
                }
            }
            
            if ([responseObject[@"data"] count] == 0 && self.models.count != 0) {
                
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


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_RecommendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_RecommendRecordCell"];
    cell.selectionStyle = 0;
    cell.countModel = self.models[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_SpendingDetailController *detailVC = [[GLMine_SpendingDetailController alloc] init];
    GLMine_SpendingCountModel *model = self.models[indexPath.row];
    detailVC.cid = model.uid;
    detailVC.type = self.type;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

#pragma 懒加载
- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}
@end
