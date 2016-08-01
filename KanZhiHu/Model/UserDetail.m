//
//  UserDetail.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserDetail.h"

@implementation UserDetail

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\nask:%@\nanswer:%@\npost:%@\nagree:%@\nagreei:%@\nagreeiratio:%@\nagreeiw:%@\nagreeiratiow:%@\nratio:%@\nfollowee:%@\nfollower:%@\nfolloweri:%@\nfollowiratio:%@\nfolloweriw:%@\nfollowiratiow:%@\nthanks:%@\ntratio:%@\nfav:%@\nfratio:%@\nlogs:%@\nmostvote:%@\nmostvotepercent:%@\nmostvote5:%@\nmostvote5percent:%@\nmostvote10:%@\nmostvote10percent:%@\ncount10000:%@\ncount5000:%@\ncount2000:%@\ncount1000:%@\ncount500:%@\ncount200:%@\ncount100:%@\n}", self.class, self, @(self.ask), @(self.answer), @(self.post), @(self.agree), @(self.agreei), self.agreeiratio, @(self.agreeiw), self.agreeiratiow, @(self.ratio), @(self.followee), @(self.follower), @(self.followeri), self.followiraio, @(self.followeriw), self.followiratiow, @(self.thanks), @(self.tratio), @(self.fav), @(self.fratio), @(self.logs), @(self.mostvote), self.mostvotepercent, @(self.mostvote5), self.mostvote5percent, @(self.mostvote10), self.mostvote10percent, @(self.count10000), @(self.count5000), @(self.count2000), @(self.count1000), @(self.count500), @(self.count200), @(self.count100)];
}

@end
