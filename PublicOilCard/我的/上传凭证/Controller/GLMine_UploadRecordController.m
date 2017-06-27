//
//  GLMine_UploadRecordController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/26.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_UploadRecordController.h"
#import "GLMine_UploadRecordCell.h"
#import "GLMine_UploadController.h"

@interface GLMine_UploadRecordController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GLMine_UploadRecordController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationItem.title = @"凭证记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_UploadRecordCell" bundle:nil] forCellReuseIdentifier:@"GLMine_UploadRecordCell"];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)upload:(id)sender {
    
    self.hidesBottomBarWhenPushed = YES;
    GLMine_UploadController *uploadVC = [[GLMine_UploadController alloc] init];
    [self.navigationController pushViewController:uploadVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}
#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (self.models.count == 0) {
//        self.nodataV.hidden = NO;
//    }else{
//        self.nodataV.hidden = YES;
//    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_UploadRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_UploadRecordCell"];
    cell.selectionStyle = 0;
//    cell.model = self.models[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
