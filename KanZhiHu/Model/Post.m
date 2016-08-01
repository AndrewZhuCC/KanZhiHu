//
//  Post.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "Post.h"

@implementation Post

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ndate:%@\nname:%@\npic:%@\npublishtime:%@\ncount:%@\nexcerpt:%@\n}", self.class, self, self.date, self.name, self.pic, @(self.publishtime), @(self.count), self.excerpt];
}

@end
