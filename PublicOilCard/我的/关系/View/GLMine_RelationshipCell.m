//
//  GLMine_RelationshipCell.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_RelationshipCell.h"

@interface GLMine_RelationshipCell ()
@property (weak, nonatomic) IBOutlet UILabel *subordinateLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UILabel *delegateOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *delegateTwoLabel;

@end

@implementation GLMine_RelationshipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GLMine_RelationshipModel *)model{
    _model = model;
    self.subordinateLabel.text = [NSString stringWithFormat:@"经理:%@人",model.subordinateNum];
    self.memberLabel.text = [NSString stringWithFormat:@"会员:%@人",model.subordinateNum];
    self.delegateOneLabel.text = [NSString stringWithFormat:@"首期代理:%@人",model.subordinateNum];
    self.delegateTwoLabel.text = [NSString stringWithFormat:@"二期代理:%@人",model.subordinateNum];
}
@end
