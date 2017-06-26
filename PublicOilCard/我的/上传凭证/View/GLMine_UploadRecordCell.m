//
//  GLMine_UploadRecordCell.m
//  PublicOilCard
//
//  Created by 龚磊 on 2017/6/26.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "GLMine_UploadRecordCell.h"

@interface GLMine_UploadRecordCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation GLMine_UploadRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
