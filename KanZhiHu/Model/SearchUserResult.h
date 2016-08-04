//
//  SearchUserResult.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchUserModel.h"

@interface SearchUserResult : NSObject

@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSArray<SearchUserModel *> *users;

@end
