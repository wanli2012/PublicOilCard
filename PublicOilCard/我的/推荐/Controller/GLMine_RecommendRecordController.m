//
//  GLMine_RecommendRecordController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_RecommendRecordController.h"
#import "GLMine_RecommendRecordCell.h"
#import "QQPopMenuView.h"

@interface GLMine_RecommendRecordController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic)BOOL refreshType;//判断刷新状态 默认为no

@end

@implementation GLMine_RecommendRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //自定义右键
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"筛选" forState:UIControlStateNormal];
    UIImage *imgArrow = [UIImage imageNamed:@"下选三角形"];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setImage:imgArrow forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imgArrow.size.width, 0, imgArrow.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn addTarget:self  action:@selector(filte) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_RecommendRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_RecommendRecordCell"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

//筛选
-(void)filte{
    __weak typeof(self) weakself = self;
    QQPopMenuView *popview = [[QQPopMenuView alloc]initWithItems:@[@{@"title":@"会员",@"imageName":@""}, @{@"title":@"非会员",@"imageName":@""}]
                                                           width:100
                                                triangleLocation:CGPointMake([UIScreen mainScreen].bounds.size.width-30, 64+5)
                                                          action:^(NSInteger index) {
                                                              
                                                              _refreshType = NO;
//                                                              _page=1;
//                                                              _messageType = index + 1;
//                                                              [weakself initdatasource];
                                                          }];
    popview.isHideImage = YES;
    
    [popview show];
    
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_RecommendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_RecommendRecordCell"];
    cell.selectionStyle = 0;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
