//
//  SearchUserTableViewCell.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchUserModel;

@interface SearchUserTableViewCell : UITableViewCell
- (void)configureWithEntity:(SearchUserModel *)entity;
@end
