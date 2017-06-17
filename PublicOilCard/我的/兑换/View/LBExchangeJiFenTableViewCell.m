//
//  LBExchangeJiFenTableViewCell.m
//  PublicOilCard
//
//  Created by 四川三君科技有限公司 on 2017/6/17.
//  Copyright © 2017年 三君科技有限公司. All rights reserved.
//

#import "LBExchangeJiFenTableViewCell.h"

@interface LBExchangeJiFenTableViewCell () <UITextFieldDelegate>

@end

@implementation LBExchangeJiFenTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ([string isEqualToString:@"\n"]) {
        [self.textf endEditing:YES];
    }

    return YES;
}


@end
