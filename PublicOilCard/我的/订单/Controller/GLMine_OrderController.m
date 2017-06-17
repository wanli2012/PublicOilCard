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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_CollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_CollectCell"];
    cell.selectionStyle = 0;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    GLMine_OrderSectionHeader *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"GLMine_OrderSectionHeader"];

    return headerview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

@end
