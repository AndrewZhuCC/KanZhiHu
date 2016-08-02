//
//  TopAnswersTableViewCell.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/2.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserTopAnswers;

@interface TopAnswersTableViewCell : UITableViewCell
- (void)configureCellWithEntity:(UserTopAnswers *)entity;
@end
