//
//  Post.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "Post.h"

@implementation Post

- (id)copyWithZone:(NSZone *)zone {
    Post *result = [[Post allocWithZone:zone] init];
    result.date = self.date;
    result.name = self.name;
    result.pic = self.pic;
    result.publishtime = self.publishtime;
    result.count = self.count;
    result.excerpt = self.excerpt;
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ndate:%@\nname:%@\npic:%@\npublishtime:%@\ncount:%@\nexcerpt:%@\n}", self.class, self, self.date, self.name, self.pic, @(self.publishtime), @(self.count), self.excerpt];
}

@end
