//
//  GLMine_updateManagerController.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/15.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_updateManagerController.h"
#import "GLMine_updateManagerCell.h"
#import "GLMine_updateManagerAllCell.h"
#import "GLMine_updateManagerModel.h"
#import "GLMine_updateManagerDealNowCell.h"

@interface GLMine_updateManagerController ()<UITableViewDelegate,UITableViewDataSource>
{
    //假数据源
    NSArray *_keyArr;
    NSMutableArray *_tempArr;
    BOOL _isCheckAll;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *tempArr;

@property (nonatomic, strong)NSMutableArray *models;

@end

@implementation GLMine_updateManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"升级管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerAllCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerAllCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"GLMine_updateManagerDealNowCell" bundle:nil] forCellReuseIdentifier:@"GLMine_updateManagerDealNowCell"];
    
    _keyArr = @[@"赠送6000积分送6000积分送6000积分送6000积分送6000积分",
                @"用户赠送6000积分送6000积分送6000积分送6000积分送6000积分名",
                @"I赠送6000积分送6000积分送6000积分送6000积分送6000积分D",
                @"二维赠送6000积分送6000积分送6000积分送6000积分送6000积分码",
                @"身份证赠送6000积分送6000积分送6000积分送6000积分送6000积分号码",
                @"推赠送6000积分送6000积分送6000积分送6000积分送6000积分荐人",
                @"推荐人ID"];


}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.models.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        
        if (_keyArr.count <= 3) {
            
            return _keyArr.count ;
            
        }else{
            
            return self.tempArr.count;
        }
    }else{
        return _keyArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (self.tempArr.count >= 3) {
            if (indexPath.row <= self.tempArr.count -3) {
                
                GLMine_updateManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateManagerCell"];
                cell.selectionStyle = 0;
                return cell;
                
            }else if(indexPath.row == self.tempArr.count - 2){
                
                GLMine_updateManagerAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateManagerAllCell"];
                cell.selectionStyle = 0;
                cell.index = indexPath.section;
                cell.model = self.models[indexPath.section];
                
                //回调
                __weak __typeof(self)weakSelf = self;
                cell.returnBlock = ^(BOOL isCheckAll,NSInteger index){
                    GLMine_updateManagerModel *model = weakSelf.models[indexPath.section];
                    model.isCheckAll = !model.isCheckAll;
                    [_tempArr removeAllObjects];
                    
                    if (model.isCheckAll == YES) {
                        for (int i = 0; i < _keyArr.count; i ++) {
                            [_tempArr addObject:_keyArr[i]];
                        }
                        [_tempArr addObject:@""];
                        [_tempArr addObject:@""];
                        
                    }else{
                        for (int i = 0; i < 2; i ++) {
                            [_tempArr addObject:_keyArr[i]];
                        }
                        [_tempArr addObject:@""];
                        [_tempArr addObject:@""];
                        
                    }
                    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationAutomatic];
                };
                return cell;
            }else{
                GLMine_updateManagerModel *model = self.models[indexPath.section];
                if (model.isCheckAll) {
                    return [[UITableViewCell alloc] init];
                }else{
                    
                    GLMine_updateManagerDealNowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateManagerDealNowCell"];
                    cell.selectionStyle = 0;
                    return cell;
                }
            }
        }else{
            
            GLMine_updateManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateManagerCell"];
            cell.selectionStyle = 0;
            return cell;
            
        }
        
    }else{
        GLMine_updateManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLMine_updateManagerCell"];
        cell.selectionStyle = 0;
        return cell;

    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headerLabel.backgroundColor = TABBARTITLE_COLOR;
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    GLMine_updateManagerModel *model = self.models[section];
    headerLabel.text = model.content;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GLMine_updateManagerModel *model = self.models[indexPath.section];
 
    
    if(model.isCheckAll && (indexPath.row == self.tempArr.count - 1)){
        return 0;
    }else{
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        return self.tableView.rowHeight;
    }
    
}

- (NSMutableArray *)models{
    if (!_models) {
        _models = [[NSMutableArray alloc] init];
        NSArray *contents = @[@"首期: 6000级代理商尊享权益(限1000名)",@"二期:12000级代理快点快点看"];
        NSArray *isCA = @[@(NO),@(NO)];
        for (int i = 0; i < 2; i ++) {
            GLMine_updateManagerModel *model = [[GLMine_updateManagerModel alloc] init];
            model.content = contents[i];
            model.isCheckAll = [isCA[i] boolValue];
            [_models addObject:model];
        }
    }
    return _models;
}
- (NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [[NSMutableArray alloc] init];
        if (_keyArr.count >= 3) {
            for (int i = 0; i < 2; i ++) {
                [_tempArr addObject:_keyArr[i]];
            }
            [_tempArr addObject:@""];
            [_tempArr addObject:@""];
        }
    }
    return _tempArr;
}
@end
