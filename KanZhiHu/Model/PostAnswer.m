//
//  PostAnswer.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostAnswer.h"

@implementation PostAnswer

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ntitle:%@\ntime:%@\nsummary:%@\nquestionid:%@\nanswerid:%@\nauthorhash:%@\navatar:%@\nvote:%@\n}", self.class, self, self.title, self.time, self.summary, self.questionid, self.answerid, self.authorhash, self.avatar, @(self.vote)];
}

@end
