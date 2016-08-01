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
@property (assign, nonatomic) NSInteger answer;
@property (assign, nonatomic) NSInteger agree;
@property (assign, nonatomic) NSInteger follower;

@end
