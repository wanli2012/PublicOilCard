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

@interface GLMineHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    GLMine_HeaderView *_header;
}

@property (nonatomic, strong)UICollectionView *collectionV;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)NSArray *imageArr;

@end

static NSString *cellID = @"GLMine_collectionCell";
static NSString *headerID = @"GLMine_HeaderView";
@implementation GLMineHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
 

      [self.view addSubview:self.collectionV];
    //注册头视图
    [self.collectionV registerClass:[GLMine_HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
//    [self.collectionV registerNib:[UINib nibWithNibName:@"GLMine_HeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GLMine_HeaderView"];
    [self.collectionV registerNib:[UINib nibWithNibName:@"GLMine_collectionCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 10, 0)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setMinimumInteritemSpacing:10];
        [flowLayout setMinimumLineSpacing:10];
        
        _collectionV =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64 - 50)collectionViewLayout:flowLayout];
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2 - 5 ,(_collectionV.height - 220)/2);
        _collectionV.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed = YES;
    switch (indexPath.row) {
        case 0:
        {
            if ([[UserModel defaultUser].group_id integerValue] != 6) {
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
    [_header.picImagaV addGestureRecognizer:tap];
    
    [_header.openCardBtn addTarget:self action:@selector(openCard) forControlEvents:UIControlEventTouchUpInside];
    [_header.exchangeBtn addTarget:self action:@selector(exchange) forControlEvents:UIControlEventTouchUpInside];

    
//    [header.adImageV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@0);
//    }];
    if ([[UserModel defaultUser].group_id integerValue] != 6) {

        _header.openCardBtn.hidden = YES;
        _header.exchangeBtn.hidden = YES;
    }else{
        _header.openCardBtn.hidden = NO;
        _header.exchangeBtn.hidden = NO;

    }
    
    return _header;
}
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if ([[UserModel defaultUser].group_id integerValue] != 6) {
        
        return CGSizeMake(SCREEN_WIDTH, 220);
        
    }else{
        
        return CGSizeMake(SCREEN_WIDTH, 290);
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
