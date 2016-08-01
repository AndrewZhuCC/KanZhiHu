//
//  GetPostsResult.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "GetPostsResult.h"
#import "Post.h"

#import <YYModel/YYModel.h>

@interface GetPostsResult () <YYModel>

@end

@implementation GetPostsResult

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"posts":Post.class};
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ncount:%@\nposts:%@\n}", self.class, self, @(self.count), self.posts];
}

@end
