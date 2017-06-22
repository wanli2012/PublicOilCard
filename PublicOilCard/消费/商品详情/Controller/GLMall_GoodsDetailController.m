//
//  GLMall_GoodsDetailController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMall_GoodsDetailController.h"
#import "GLMall_GoodsHeaderView.h"
#import "GLMallHomeCell.h"
#import "LBMineCenterPayPagesViewController.h"

@interface GLMall_GoodsDetailController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,GLMall_GoodsHeaderViewDelegate>
{
    NSInteger _sum;//商品购买数量
}

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property(assign , nonatomic)CGFloat headerImageHeight;

@property (strong, nonatomic)LoadWaitView *loadV;
@property (nonatomic,strong)NodataView *nodataV;
@property (nonatomic, strong)NSMutableArray *models;
@property (nonatomic, strong)NSDictionary *dataDic;
@property (nonatomic, assign)NSInteger page;//页数

@end

@implementation GLMall_GoodsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buyBtn.layer.cornerRadius = 5.f;
    self.navigationItem.title = @"详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerImageHeight = 120;
    //设置layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 -5, 224);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    self.collectionView.collectionViewLayout = layout;
    
    _sum = 1;
    
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"余额"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    [self.collectionView registerNib:[UINib nibWithNibName:@"GLMall_GoodsHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GLMall_GoodsHeaderView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GLMallHomeCell" bundle:nil] forCellWithReuseIdentifier:@"GLMallHomeCell"];
    __weak __typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf updateData:YES];
        
    }];
    
    
    // 设置文字
    [header setTitle:@"快扯我，快点" forState:MJRefreshStateIdle];
    
    [header setTitle:@"数据要来啦" forState:MJRefreshStatePulling];
    
    [header setTitle:@"服务器正在狂奔 ..." forState:MJRefreshStateRefreshing];
    
    
    self.collectionView.mj_header = header;
    
    [self updateData:YES];
    
}

- (void)updateData:(BOOL)status {
    
    if (status) {
        
        self.page = 1;
        [self.models removeAllObjects];
        
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"goods_id"] = self.goods_id;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    
    [NetworkManager requestPOSTWithURLStr:@"ShopInfo/goods_info" paramDic:dict finish:^(id responseObject) {
        [self endRefresh];
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {
            
            self.dataDic = responseObject[@"data"][@"goods_details"];
            
            for (NSDictionary * dic in responseObject[@"data"][@"guess_goods"]) {
                
                GLMallHomeGoodsModel *model = [GLMallHomeGoodsModel mj_objectWithKeyValues:dic];
                [self.models addObject:model];
            }
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

//立即购买
- (IBAction)buyNow:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    LBMineCenterPayPagesViewController *payVC = [[LBMineCenterPayPagesViewController alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"user_name"] = [UserModel defaultUser].username;
    dict[@"group_id"] = [UserModel defaultUser].group_id;
    dict[@"goods_id"] = self.dataDic[@"goods_id"];
    dict[@"goods_num"] = [NSString stringWithFormat:@"%zd",_sum];
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"ShopInfo/buy_order" paramDic:dict finish:^(id responseObject) {
        
        [_loadV removeloadview];
        
        if ([responseObject[@"code"] integerValue]==1) {
            
            payVC.addtime =[NSString stringWithFormat:@"%@", responseObject[@"data"][@"addtime"]];
            payVC.order_id = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"order_id"]];
            payVC.order_num = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"order_num"]];
            payVC.realy_price = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"realy_price"]];
            [self.navigationController pushViewController:payVC animated:YES];
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
    } enError:^(NSError *error) {
        [_loadV removeloadview];
        [MBProgressHUD showError:error.localizedDescription];
    }];

    
}

//收藏
- (void)collect {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"uid"] = [UserModel defaultUser].uid;
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"goods_id"] = self.goods_id;
    
    _loadV=[LoadWaitView addloadview:[UIScreen mainScreen].bounds tagert:self.view];
    [NetworkManager requestPOSTWithURLStr:@"UserInfo/collec_add" paramDic:dict finish:^(id responseObject) {
        [self endRefresh];
        [_loadV removeloadview];
        
        [MBProgressHUD showError:responseObject[@"message"]];

    } enError:^(NSError *error) {
        [_loadV removeloadview];

        [MBProgressHUD showError:error.localizedDescription];
    }];

}

//取到购买数量
-(void)changeNum:(NSString *)text{
    
    _sum = [text  integerValue];
    
}
#pragma UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.models.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GLMallHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GLMallHomeCell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    GLMall_GoodsHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GLMall_GoodsHeaderView" forIndexPath:indexPath];
    
    NSString *attrStr = self.dataDic[@"goods_info"];
    NSString *strone = [NSString stringWithFormat:@"[%@]",attrStr];
    long len1 = [strone length];
    NSString *strtwo = [NSString stringWithFormat:@"[%@] %@",attrStr,self.dataDic[@"goods_name"]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:strtwo];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,len1)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(0,len1)];
    
    if(attrStr.length <= 0){
        
        header.detailLabel.text = self.dataDic[@"goods_name"];
        
    }else{
        
        header.detailLabel.attributedText = str;
    }

    if([self.dataDic[@"discount"] isEqual:[NSNull null]] || self.dataDic[@"discount"] == nil){
        header.priceLabel.text = @"¥0";
    }else{
        
        header.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.dataDic[@"discount"]];
    }
    
    if([self.dataDic[@"salenum"] isEqual:[NSNull null]]|| self.dataDic[@"salenum"] == nil){
        header.countLabel.text = @"总销量:0";
    }else{
    
        header.countLabel.text = [NSString stringWithFormat:@"总销量:%@",self.dataDic[@"salenum"]];
    }
    
    if([self.dataDic[@"goods_num"] isEqual:[NSNull null]]|| self.dataDic[@"goods_num"] == nil){
        header.stockLabel.text = @"库存:0";
    }else{
        header.stockLabel.text = [NSString stringWithFormat:@"库存:%@",self.dataDic[@"goods_num"]];
    }
    
    header.stockNum = self.dataDic[@"goods_num"];
    header.delegate = self;
    
    [header addSubview:self.cycleScrollView];
    
    return header;
}
-(SDCycleScrollView*)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _headerImageHeight)
                                                              delegate:self
                                                      placeholderImage:[UIImage imageNamed:@"轮播占位图"]];
        
        _cycleScrollView.localizationImageNamesGroup = @[];
        _cycleScrollView.placeholderImageContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;// 翻页 右下角
        _cycleScrollView.titleLabelBackgroundColor = YYSRGBColor(241, 242, 243, 1);// 图片对应的标题的 背景色。（因为没有设标题）
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"轮播占位图"];
        _cycleScrollView.pageControlDotSize = CGSizeMake(10, 10);
    }
    
    return _cycleScrollView;
    
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    NSString *content;
    if (self.dataDic) {
        
        NSString *attrStr = self.dataDic[@"goods_info"];
        NSString *strone = [NSString stringWithFormat:@"[%@]",attrStr];
        long len1 = [strone length];
        NSString *strtwo = [NSString stringWithFormat:@"[%@] %@",attrStr,self.dataDic[@"goods_name"]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:strtwo];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,len1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17.0f] range:NSMakeRange(0,len1)];
        content = [str string];
    }else{
        content = @"暂无";
    }

    CGSize titleSize = [content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return CGSizeMake(SCREEN_WIDTH, titleSize.height + self.headerImageHeight + 130);
}

#pragma 懒加载
- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

@end
