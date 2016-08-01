//
//  PostAnswer.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostAnswer.h"

@implementation PostAnswer

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) result = [[self.class allocWithZone:zone] init];
    result.title = self.title;
    result.time = self.time;
    result.summary = self.summary;
    result.questionid = self.questionid;
    result.answerid = self.answerid;
    result.authorhash = self.authorhash;
    result.avatar = self.avatar;
    result.vote = self.vote;
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ntitle:%@\ntime:%@\nsummary:%@\nquestionid:%@\nanswerid:%@\nauthorhash:%@\navatar:%@\nvote:%@\n}", self.class, self, self.title, self.time, self.summary, self.questionid, self.answerid, self.authorhash, self.avatar, @(self.vote)];
}

@end
