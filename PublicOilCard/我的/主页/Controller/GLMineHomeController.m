//
//  GLMineHomeController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/14.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMineHomeController.h"
//#import <Masonry/Masonry.h>
#import "GLMine_HeaderView.h"
#import "GLMine_collectionCell.h"
#import "GLMine_CollectController.h"
#import "GLMine_OpenCardController.h"
#import "GLMine_InfoController.h"
#import "GLMine_PersonInfoController.h"
#import "GLMine_OrderController.h"
#import "GLMine_RecommendController.h"
#import "GLMine_updateManagerController.h"
#import "GLMine_SetController.h"
#import "GLMine_ExchangeRecordController.h"
#import "GLMine_OpenController.h"
#import "GLMine_RelationshipController.h"
#import "LBExchangeViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface GLMineHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>
{
    GLMine_HeaderView *_header;
}

@property (nonatomic, strong)UICollectionView *collectionV;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *imageArr;

@property (nonatomic, strong)SDCycleScrollView *cycleScrollView;
@property(assign , nonatomic)CGFloat headerImageHeight;

@end

static NSString *cellID = @"GLMine_collectionCell";
static NSString *headerID = @"GLMine_HeaderView";
@implementation GLMineHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
 
      [self.view addSubview:self.collectionV];
    self.headerImageHeight = 80 * autoSizeScaleY;
    //注册头视图
//    [self.collectionV registerClass:[GLMine_HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [self.collectionV registerNib:[UINib nibWithNibName:@"GLMine_HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    [self.collectionV registerNib:[UINib nibWithNibName:@"GLMine_collectionCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}
//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
   if ([[UserModel defaultUser].group_id integerValue] == 1 || [[UserModel defaultUser].group_id integerValue] == 2 || [[UserModel defaultUser].group_id integerValue] == 3 ) {
        
        self.tabBarController.tabBar.hidden = YES;
        
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
    [self refresh];
}
- (void)refresh {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [UserModel defaultUser].token;
    dict[@"uid"] = [UserModel defaultUser].uid;

    [NetworkManager requestPOSTWithURLStr:@"user/refresh" paramDic:dict finish:^(id responseObject) {
  
        if ([responseObject[@"code"] integerValue]==1) {
            [UserModel defaultUser].price = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"price"]];
            [UserModel defaultUser].mark = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"mark"]];
            [UserModel defaultUser].recNumber = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"recNumber"]];
            [UserModel defaultUser].yue = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"yue"]];
            [UserModel defaultUser].username = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"username"]];
            [UserModel defaultUser].truename = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"truename"]];
            [UserModel defaultUser].group_name = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"group_name"]];
            [UserModel defaultUser].isHaveOilCard = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"isHaveOilCard"]];
            
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].price] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].price = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].mark] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].mark = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].recNumber] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].recNumber = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].username] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].username = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].truename] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].truename = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].group_name] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].group_name = @"";
            }
            if ([[NSString stringWithFormat:@"%@",[UserModel defaultUser].isHaveOilCard] rangeOfString:@"null"].location != NSNotFound) {
                
                [UserModel defaultUser].isHaveOilCard = @"";
            }
            
            [usermodelachivar achive];
        }else{
            
            [MBProgressHUD showError:responseObject[@"message"]];
        }
        
        [self.collectionV reloadData];
        
    } enError:^(NSError *error) {
  
        [MBProgressHUD showError:error.localizedDescription];
    }];
}
//设置
- (IBAction)set:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    GLMine_SetController *setVC = [[GLMine_SetController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//消息
- (IBAction)info:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_InfoController *infoVC = [[GLMine_InfoController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//个人信息
- (void)personInfo{
    self.hidesBottomBarWhenPushed = YES;
    GLMine_PersonInfoController *perosnInfoVC = [[GLMine_PersonInfoController alloc] init];
    [self.navigationController pushViewController:perosnInfoVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//开卡
- (void)openCard {
    self.hidesBottomBarWhenPushed = YES;
    GLMine_OpenCardController *openVC = [[GLMine_OpenCardController alloc] init];
    [self.navigationController pushViewController:openVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
//兑换
- (void)exchange {
    
    self.hidesBottomBarWhenPushed = YES;
    LBExchangeViewController *exchangeVC = [[LBExchangeViewController alloc] init];
    [self.navigationController pushViewController:exchangeVC animated:YES];
    
    self.hidesBottomBarWhenPushed = NO;

}
#pragma mark 懒加载

-(UICollectionView *)collectionV{
    
    if (!_collectionV) {
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setMinimumInteritemSpacing:10];
        [flowLayout setMinimumLineSpacing:10];
        
        
        _collectionV =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        if ([[UserModel defaultUser].group_id integerValue] == 1 || [[UserModel defaultUser].group_id integerValue] == 2 || [[UserModel defaultUser].group_id integerValue] == 3 ) {

            _collectionV.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 5,(SCREEN_HEIGHT-64- 200 * autoSizeScaleY)/2 - 10);
        }else{//会员身份
            _collectionV.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
            flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 5, 140*autoSizeScaleY);

        }
        _collectionV.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        _collectionV.backgroundColor = YYSRGBColor(249, 250, 251, 1);
        _collectionV.alwaysBounceVertical = YES;
        _collectionV.showsVerticalScrollIndicator = NO;
//        [_collectionV setContentInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        //设置代理
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
    }
    return _collectionV;
}
#pragma UICollectionviewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_collectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.picImageV.image = [UIImage imageNamed:self.imageArr[indexPath.row]];
    
    if (indexPath.row == 0 || indexPath.row == 2) {
        
        cell.leftViewWidth.constant = 30;
        cell.rightViewWidth.constant = -22;
    }else{
        cell.leftViewWidth.constant = 8;
        cell.rightViewWidth.constant = 30;
    }
    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.topViewHeight.constant = 15;
        cell.bottomViewHeight.constant = 8;
    }else{
        cell.topViewHeight.constant = 8;
        cell.bottomViewHeight.constant = 15;
    }
//    cell.cellView.layer.cornerRadius = 10;
//    cell.cellView.layer.cornerRadius = 10.0f;
//    cell.cellView.layer.borderWidth = 0.5f;
//    cell.cellView.layer.borderColor = [UIColor clearColor].CGColor;
//    cell.cellView.layer.masksToBounds = YES;
//    
//    cell.cellView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    cell.cellView.layer.shadowOffset = CGSizeMake(0, 0);
//    cell.cellView.layer.shadowRadius = 4.0f;
//    cell.cellView.layer.shadowOpacity = 0.5f;
//    cell.cellView.layer.masksToBounds = NO;
//    cell.cellView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    cell.cellView.layer.cornerRadius = 5;
//    cell.cellView.layer.masksToBounds = YES;
    cell.cellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//shadowColor阴影颜色
    cell.cellView.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    cell.cellView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    cell.cellView.layer.shadowRadius = 5;//阴影半径，默认3
    return cell;
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    if (section == 0 || section == 2) {
//        return UIEdgeInsetsMake(0, 30, 0, 0);
//    }else{
//        return UIEdgeInsetsMake(0, 0, 0, 30);
//    }
//    
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    switch (indexPath.row) {
        case 0:
        {
            if ([[UserModel defaultUser].group_id integerValue] != 6) {
                if ([[UserModel defaultUser].group_id integerValue] == 3) {
                    [MBProgressHUD showError:@"权限不足,无法开通下级"];
                }
                GLMine_OpenController *openVC = [[GLMine_OpenController alloc] init];
                [self.navigationController pushViewController:openVC animated:YES];
                
            }else{
                
                GLMine_CollectController *collectVC = [[GLMine_CollectController alloc] init];
                [self.navigationController pushViewController:collectVC animated:YES];
            }
        }
            break;
        case 1:
        {
            if ([[UserModel defaultUser].group_id integerValue] != 6) {
                GLMine_RelationshipController *vc = [[GLMine_RelationshipController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                GLMine_OrderController *orderVC = [[GLMine_OrderController alloc] init];
                [self.navigationController pushViewController:orderVC animated:YES];

            }
                }
            break;
        case 2:
        {
            if ([[UserModel defaultUser].group_id integerValue] != 6) {
                
                LBExchangeViewController *exchageVC = [[LBExchangeViewController alloc] init];
                [self.navigationController pushViewController:exchageVC animated:YES];
            }else{
                
                GLMine_updateManagerController *updateVC = [[GLMine_updateManagerController alloc] init];
                [self.navigationController pushViewController:updateVC animated:YES];
                
            }
        }
            break;
        case 3:
        {
            GLMine_RecommendController *recommendVC = [[GLMine_RecommendController alloc] init];
            [self.navigationController pushViewController:recommendVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    self.hidesBottomBarWhenPushed = NO;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
             viewForSupplementaryElementOfKind:(NSString *)kind
                                   atIndexPath:(NSIndexPath *)indexPath {

    _header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
    
    //跳转到个人信息界面
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(personInfo)];
    [_header.picImageV addGestureRecognizer:tap];
    
    [_header.openCardBtn addTarget:self action:@selector(openCard) forControlEvents:UIControlEventTouchUpInside];
    [_header.exchangeBtn addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];

    //数据显示
    _header.IDLabel.text = [NSString stringWithFormat:@"ID:%@",[UserModel defaultUser].username];
    _header.nameLabel.text= [NSString stringWithFormat:@"%@:%@",[UserModel defaultUser].group_name,[UserModel defaultUser].truename];

    if([[UserModel defaultUser].price floatValue]> 100000){
        _header.xiaofeiLabel.text = [NSString stringWithFormat:@"%.2f万",[[UserModel defaultUser].price floatValue]/10000];
    }else{
        _header.xiaofeiLabel.text = [NSString stringWithFormat:@"%@元",[UserModel defaultUser].price];
    }
    if([[UserModel defaultUser].mark floatValue]> 100000){
        _header.jifenLabel.text = [NSString stringWithFormat:@"%.2f万",[[UserModel defaultUser].mark floatValue]/10000];
    }else{
        _header.jifenLabel.text = [NSString stringWithFormat:@"%@元",[UserModel defaultUser].mark];
    }
    if([[UserModel defaultUser].yue floatValue]> 100000){
        _header.jiangliLabel.text = [NSString stringWithFormat:@"%.2f万",[[UserModel defaultUser].yue floatValue]/10000];
    }else{
        _header.jiangliLabel.text = [NSString stringWithFormat:@"%@元",[UserModel defaultUser].yue];
    }

    _header.tuijianLabel.text = [NSString stringWithFormat:@"%@人",[UserModel defaultUser].recNumber];
    
    //判断是否显示vip标志
    if ([[UserModel defaultUser].isHaveOilCard integerValue] == 1) {
        _header.vipImageV.hidden = NO;
    }else{
        _header.vipImageV.hidden = YES;
    }
    
    [_header addSubview:self.cycleScrollView];
    
    //区分会员与其他身份的界面
    if ([[UserModel defaultUser].group_id integerValue] == 1|| [[UserModel defaultUser].group_id integerValue] == 2|| [[UserModel defaultUser].group_id integerValue] == 3) {

        _header.openCardBtn.hidden = YES;
        _header.exchangeBtn.hidden = YES;
        _header.middleViewBottom.constant = 0;
        self.cycleScrollView.frame = CGRectMake(0, 200 * autoSizeScaleY, SCREEN_WIDTH, 0);
        _header.backgroundColor = [UIColor whiteColor];
        
    }else{
        
        _header.openCardBtn.hidden = NO;
        _header.exchangeBtn.hidden = NO;
        _header.middleViewBottom.constant = _headerImageHeight;
        self.cycleScrollView.frame = CGRectMake(0, 200 * autoSizeScaleY, SCREEN_WIDTH, _headerImageHeight);

        _header.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return _header;
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
    
    if ([[UserModel defaultUser].group_id integerValue] != 6) {//非会员
        
        return CGSizeMake(SCREEN_WIDTH, 200 * autoSizeScaleY);
        
    }else{//会员
        
        return CGSizeMake(SCREEN_WIDTH, 200 * autoSizeScaleY + _headerImageHeight);
    }
}

#pragma 懒加载
- (NSArray *)titleArr{
    if (!_titleArr) {

        if ([[UserModel defaultUser].group_id integerValue] == 6 || [[UserModel defaultUser].group_id integerValue] == 4) {
             _titleArr=[NSArray arrayWithObjects:@"收藏",@"订单",@"升级管理",@"推荐", nil];
        }else if([[UserModel defaultUser].group_id integerValue] == 1 ||[[UserModel defaultUser].group_id integerValue] == 2 || [[UserModel defaultUser].group_id integerValue] == 3){
            _titleArr=[NSArray arrayWithObjects:@"开通",@"关系",@"兑换",@"推荐", nil];
        }
    }
    return _titleArr;
}
- (NSArray *)imageArr{
    if (!_imageArr) {
       if ([[UserModel defaultUser].group_id integerValue] == 6 || [[UserModel defaultUser].group_id integerValue] == 4) {
           
           _imageArr = [NSArray arrayWithObjects:@"收藏",@"订单",@"升级管理",@"推荐", nil];
       }else{
           _imageArr = [NSArray arrayWithObjects:@"开通",@"关系",@"兑换",@"推荐", nil];
       }
    }
    return _imageArr;
}
@end
