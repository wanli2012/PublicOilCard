//
//  GLMine_RelationshipController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_RelationshipController.h"
//#import "GLMine_RecommendRecordCell.h"
#import "GLMine_RelationshipHeader.h"
#import "GLMine_RelationshipCell.h"

@interface GLMine_RelationshipController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *models;

@end

@implementation GLMine_RelationshipController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"关系";
//   [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_RecommendRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_RecommendRecordCell"];
    [self.tableView registerClass:[GLMine_RelationshipHeader class] forHeaderFooterViewReuseIdentifier:@"GLMine_RelationshipHeader"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_RelationshipCell" bundle:nil] forCellReuseIdentifier:@"GLMine_RelationshipCell"];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GLMine_RelationshipModel *model = self.models[section];
    return model.isExpanded?1:0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_RelationshipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_RelationshipCell"];
    cell.selectionStyle = 0;
    cell.model = self.models[indexPath.section];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GLMine_RelationshipHeader * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GLMine_RelationshipHeader"];
    if (!headerView) {
        headerView = [[GLMine_RelationshipHeader alloc] initWithReuseIdentifier:@"GLMine_RelationshipHeader"];
    }
    headerView.sectionModel = self.models[section];
    headerView.expandCallback = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}

#pragma  懒加载

- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i ++) {
            GLMine_RelationshipModel *model = [[GLMine_RelationshipModel alloc] init];
            model.IDNum = [NSString stringWithFormat:@"AB11221212 %d",i];
            model.name = [NSString stringWithFormat:@"梁朝伟 %d",i];
            model.date = [NSString stringWithFormat:@"2017-06-%d",i];
            model.subordinateNum = [NSString stringWithFormat:@"1%d",i];
            model.memberNum = [NSString stringWithFormat:@"2%d",i];
            model.firstDelegateNum = [NSString stringWithFormat:@"3%d",i];
            model.secondDelegateNum = [NSString stringWithFormat:@"4%d",i];
            
            [_models addObject:model];
        }
    }
    return _models;
}
@end
