//
//  GLMine_SpendingRecordController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/7/20.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_SpendingRecordController.h"
#import "GLMine_SpendingRecordCell.h"

@interface GLMine_SpendingRecordController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_SpendingRecordController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_SpendingRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_SpendingRecordCell"];
    
}

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_SpendingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_SpendingRecordCell"];
    cell.selectionStyle = 0;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
