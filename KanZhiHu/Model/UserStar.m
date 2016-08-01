//
//  UserStar.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserStar.h"

@implementation UserStar

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\nanswerrank:%@\nagreerank:%@\nratiorank:%@\nfollowerrank:%@\nfavrank:%@\ncount1000rank:%@\ncount100rank:%@\n}", self.class, self, @(self.answerrank), @(self.agreerank), @(self.ratiorank), @(self.followerrank), @(self.favrank), @(self.count1000rank), @(self.count100rank)];
}

@end
