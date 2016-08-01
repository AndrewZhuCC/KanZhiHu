//
//  UserTopAnswers.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserTopAnswers.h"

@implementation UserTopAnswers

- (id)copyWithZone:(NSZone *)zone {
    typeof(self) result = [[self.class allocWithZone:zone] init];
    result.title = self.title;
    result.link = self.link;
    result.agree = self.agree;
    result.date = self.date;
    result.ispost = self.ispost;
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ntitle:%@\nlink:%@\nagree:%@\ndate:%@\nispost:%@\n}", self.class, self, self.title, self.link, @(self.agree), self.date, @(self.ispost)];
}

@end
