//
//  GetPostAnswersResult.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "GetPostAnswersResult.h"
#import "PostAnswer.h"

#import <YYModel/YYModel.h>

@interface GetPostAnswersResult () <YYModel>

@end

@implementation GetPostAnswersResult

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"answers":PostAnswer.class};
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\ncount:%@\nanswers:%@\n}", self.class, self, @(self.count), self.answers];
}

@end
