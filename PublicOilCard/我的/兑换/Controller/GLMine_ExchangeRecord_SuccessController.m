//
//  GLMine_ExchangeRecord_SuccessController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/16.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_ExchangeRecord_SuccessController.h"
#import "GLMine_ExchangeRecordCell.h"

@interface GLMine_ExchangeRecord_SuccessController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_ExchangeRecord_SuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_ExchangeRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_ExchangeRecordCell"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_ExchangeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_ExchangeRecordCell"];
    cell.selectionStyle = 0;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}




@end
