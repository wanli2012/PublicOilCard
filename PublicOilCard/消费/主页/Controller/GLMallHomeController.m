//
//  GLMallHomeController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMallHomeController.h"
#import "GLMallHomeCell.h"
#import "GLMall_GoodsDetailController.h"
#import "GLHomeLiveChooseController.h"
#import "GLSet_MaskVeiw.h"

@interface GLMallHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *_dataArr;//假数据
    
    GLSet_MaskVeiw *_maskV;
    UIView *_contentView;
    GLHomeLiveChooseController *_chooseVC;
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, strong) GLHomeLiveChooseController *chooseVC;;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, strong)NSArray *dataArr;
@property (nonatomic, assign)NSInteger page;//页数
@property (nonatomic, copy)NSString *cate_id;//分类id
@property (nonatomic, copy)NSString *order_money;//售价排序
@property (nonatomic, copy)NSString *order_num;//销量排序


@end

@implementation GLMallHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.typeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [self.typeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    
    [self.moneyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [self.moneyBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    
    [self.timeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [self.timeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 70, 0, 0)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 -5, 224);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView addSubview:self.nodataV];
    self.nodataV.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"maskView_dismiss" object:nil];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLMallHomeCell" bundle:nil] forCellWithReuseIdentifier:@"GLMallHomeCell"];
    _dataArr = @[@"niday你大爷  的  男的意见啊  只要998   只要998",@"和哈大家发神经",@"niday你大爷  的  男的意见啊  只要998   只要998niday你大爷  的  男的意见啊  只要998   只要998",@"电动蝶阀"];
    
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
    
    self.collectionView.mj_header = header;
    self.collectionView.mj_footer = footer;
    
    self.cate_id = @"1";
    self.order_num = @"2";
    self.order_money = @"1";
    
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
    dict[@"page"] = [NSString stringWithFormat:@"%zd",self.page];
    dict[@"cate_id"] = self.cate_id;
    dict[@"order_money"] = self.order_money;
    dict[@"order_num"] = self.order_num;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"ShopInfo/shop_index" paramDic:dict finish:^(id responseObject) {
        [self endRefresh];
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {
            for (NSDictionary * dic in responseObject[@"data"][@"guess_goods"]) {
                
                GLMallHomeGoodsModel *model = [GLMallHomeGoodsModel mj_objectWithKeyValues:dic];
                [self.models addObject:model];
            }
            self.dataArr = responseObject[@"data"][@"goods_details"];
            
            if ([responseObject[@"data"] count] == 0 && self.models.count != 0) {
                
                [MBProgressHUD showError:responseObject[@"message"]];
            }
            
        }else{
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.collectionView reloadData];
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [self endRefresh];
        [MBProgressHUD showError:error.localizedDescription];
    }];

}
- (void)endRefresh {
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
-(NodataView*)nodataV{
    
    if (!_nodataV) {
        _nodataV=[[NSBundle mainBundle]loadNibNamed:@"NodataView" owner:self options:nil].firstObject;
        _nodataV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-114-49);
    }
    return _nodataV;
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.chooseVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        _maskV.alpha = 0;
        
    }];
    [self.typeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.moneyBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.typeBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.moneyBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.timeBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[self.topView convertRect:self.topView.bounds toView:window];
    
    _chooseVC = [[GLHomeLiveChooseController alloc] init];
    //    _chooseVC.view.frame = CGRectZero;
    
    _chooseVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, 0);
    _contentView = _chooseVC.view;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 4;
    _contentView.layer.masksToBounds = YES;
    
    _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, SCREEN_HEIGHT)];
    _maskV.bgView.alpha = 0.1;
    
    [_maskV showViewWithContentView:_contentView];
    _maskV.alpha = 0;
    

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_maskV removeFromSuperview];
}

- (IBAction)choose:(UIButton *)sender {
    if (_maskV.alpha == 0) {
        sender.selected = NO;
    }
    
    _maskV.alpha = 1;
    
    [self.typeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.moneyBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [sender setTitleColor:TABBARTITLE_COLOR forState:UIControlStateNormal];
    
    self.typeBtn.selected = NO;
    self.moneyBtn.selected = NO;
    self.timeBtn.selected = NO;
    sender.selected = YES;
    
    self.typeBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.moneyBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    self.timeBtn.imageView.transform = CGAffineTransformMakeRotation(0);
    sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    
    __weak __typeof(self)weakSelf = self;
    if (sender == self.typeBtn) {
        
        NSMutableArray *dataSource = [NSMutableArray array];
        for (int i = 0 ; i< self.dataArr.count; i++) {
           NSDictionary *dic =  self.dataArr[i];
            [dataSource addObject:dic[@"catename"]];
        }
        _chooseVC.dataSource = dataSource;
        
        _chooseVC.block = ^(NSString *value,NSInteger index){
            [weakSelf.typeBtn setTitle:value forState:UIControlStateNormal];
            NSDictionary *dic = weakSelf.dataArr[index];
            weakSelf.cate_id = dic[@"cate_id"];
            
            if ([weakSelf.typeBtn.titleLabel.text isEqualToString:@"类型"]) {
                
                weakSelf.typeBtn.imageView.image = [UIImage imageNamed:@"下选三角形"];
            }else{
                weakSelf.typeBtn.imageView.image = [UIImage imageNamed:@""];
            }
            
            [weakSelf updateData:YES];
            [weakSelf dismiss];
        };

    }else if(sender == self.moneyBtn){
        _chooseVC.dataSource = @[@"升序",@"降序"];
        
        _chooseVC.block = ^(NSString *value,NSInteger index){
            [weakSelf.moneyBtn setTitle:value forState:UIControlStateNormal];
            if(index == 0){
                
                weakSelf.order_money = @"1";
            }else{
                weakSelf.order_money = @"-1";

            }
            
            if ([weakSelf.moneyBtn.titleLabel.text isEqualToString:@"类型"]) {
                
                weakSelf.moneyBtn.imageView.image = [UIImage imageNamed:@"下选三角形"];
            }else{
                weakSelf.moneyBtn.imageView.image = [UIImage imageNamed:@""];
            }
            
            [weakSelf updateData:YES];
            [weakSelf dismiss];
        };

    }else{
        _chooseVC.dataSource = @[@"升序",@"降序"];
        
        _chooseVC.block = ^(NSString *value,NSInteger index){
            [weakSelf.timeBtn setTitle:value forState:UIControlStateNormal];
            if (index == 0) {
                weakSelf.order_num = @"2";
            }else{
                weakSelf.order_num  = @"-2";
            }
            
            if ([weakSelf.timeBtn.titleLabel.text isEqualToString:@"类型"]) {
                
                weakSelf.timeBtn.imageView.image = [UIImage imageNamed:@"下选三角形"];
            }else{
                weakSelf.timeBtn.imageView.image = [UIImage imageNamed:@""];
            }
            
            [weakSelf updateData:YES];
            [weakSelf dismiss];
        };

    }
    if (sender.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            if (_chooseVC.dataSource.count < 8) {
                _chooseVC.view.height = _chooseVC.dataSource.count * 44;
            }else{
                _chooseVC.view.height = SCREEN_HEIGHT * 0.5;
            }
            
        }];
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            _chooseVC.view.height = 0;
            
        } completion:^(BOOL finished) {
            
            _maskV.alpha = 0;
        }];
        
    }
    
    [_chooseVC.tableView reloadData];

}

#pragma  UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMallHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLMallHomeCell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    
    GLMall_GoodsDetailController *detailVC = [[GLMall_GoodsDetailController alloc] init];
    
    GLMallHomeGoodsModel *model = self.models[indexPath.row];
    
    detailVC.goods_id = model.goods_id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;
}

#pragma 懒加载
- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}
//- (GLHomeLiveChooseController *)chooseVC{
//    if (!_chooseVC) {
//        _chooseVC = [[GLHomeLiveChooseController alloc] init];
//        
//        UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
//        CGRect rect=[self.topView convertRect:self.topView.bounds toView:window];
//        
//        _chooseVC = [[GLHomeLiveChooseController alloc] init];
//        //    _chooseVC.view.frame = CGRectZero;
//        
//        _chooseVC.view.frame = CGRectMake(0,0, SCREEN_WIDTH, 0);
//        _chooseVC.view.backgroundColor = [UIColor whiteColor];
//        _chooseVC.view.layer.cornerRadius = 4;
//        _chooseVC.view.layer.masksToBounds = YES;
//        
//        _maskV = [[GLSet_MaskVeiw alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(rect), SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _maskV.bgView.alpha = 0.1;
//        
//        [_maskV showViewWithContentView:_chooseVC.view];
//        _maskV.alpha = 0;
//    }
//    return _chooseVC;
//}
@end
