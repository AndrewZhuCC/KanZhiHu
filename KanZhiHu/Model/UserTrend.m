//
//  UserTrend.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserTrend.h"

@implementation UserTrend

- (id)copyWithZone:(NSZone *)zone {
    UserTrend *result = [[UserTrend allocWithZone:zone]init];
    result.date = self.date;
    result.answer = self.answer;
    result.agree = self.agree;
    result.follower = self.follower;
    return result;
}

@end
