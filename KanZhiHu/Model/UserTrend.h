//
//  UserTrend.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTrend : NSObject <NSCopying>

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSNumber *answer;
@property (strong, nonatomic) NSNumber *agree;
@property (strong, nonatomic) NSNumber *follower;

@end
