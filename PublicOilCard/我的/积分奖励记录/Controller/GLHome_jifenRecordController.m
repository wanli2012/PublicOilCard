//
//  GLHome_jifenRecordController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/7/19.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLHome_jifenRecordController.h"
#import "GLHome_JifenRecordCell.h"

@interface GLHome_jifenRecordController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLHome_jifenRecordController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"积分记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLHome_JifenRecordCell" bundle:nil] forCellReuseIdentifier:@"GLHome_JifenRecordCell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GLHome_JifenRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLHome_JifenRecordCell"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
@end
