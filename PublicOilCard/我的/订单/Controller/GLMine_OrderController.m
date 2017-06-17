//
//  GLMine_OrderController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_OrderController.h"
#import "GLMine_CollectCell.h"
#import "GLMine_OrderSectionHeader.h"

@interface GLMine_OrderController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *sectionModels;
@property (nonatomic, strong)NSMutableArray *models;

@end

@implementation GLMine_OrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_CollectCell" bundle:nil] forCellReuseIdentifier:@"GLMine_CollectCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_OrderSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"GLMine_OrderSectionHeader"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GLMine_OrderSectionModel *model=self.sectionModels[section];

    return model.isExpanded?3:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_CollectCell"];
    cell.selectionStyle = 0;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    GLMine_OrderSectionHeader *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GLMine_OrderSectionHeader"];
    GLMine_OrderSectionModel *sectionModel = self.sectionModels[section];
    headerview.sectionModel = sectionModel;
    headerview.expandCallback = ^(BOOL isExpanded) {
        
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    headerview.sectionModel = self.sectionModels[section];
    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma  懒加载
- (NSMutableArray *)sectionModels{
    if (!_sectionModels) {
        _sectionModels = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i ++) {
            GLMine_OrderSectionModel *sectionModel = [[GLMine_OrderSectionModel alloc] init];
            sectionModel.orderNum = [NSString stringWithFormat:@"28492646276n + %d",i];
            sectionModel.orderStatus = [NSString stringWithFormat:@"已完成 %d",i];
            sectionModel.orderDate = [NSString stringWithFormat:@"2017-06-%d",i];
            [_sectionModels addObject:sectionModel];
        }
    }
    return _sectionModels;
}
- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
        
    }
    return _models;
}
@end
