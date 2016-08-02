//
//  PostAnswersTableViewCell.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostAnswer;
@class PostAnswersTableViewCell;

typedef void(^AvatarClicked)(PostAnswersTableViewCell *cell);

@interface PostAnswersTableViewCell : UITableViewCell
- (void)configureCellWithEntity:(PostAnswer *)entity;
- (void)setAvatarClick:(AvatarClicked)block;
@end
