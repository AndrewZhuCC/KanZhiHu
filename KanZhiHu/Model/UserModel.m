//
//  UserModel.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"name":@"name", @"avatar":@"avatar", @"signature":@"signature", @"userDescription":@"description", @"detail":@"detail", @"star":@"star", @"trend":@"trend", @"topanswers":@"topanswers",};
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"trend":UserTrend.class, @"topanswers":UserTopAnswers.class};
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@(%p){\nname:%@\navatar:%@\nsignature:%@\ndescription:%@\ndetail:%@\nstar:%@\ntrend:%@\ntopanswers:%@\n}", self.class, self, self.name, self.avatar, self.signature, self.userDescription, self.detail, self.star, self.trend, self.topanswers];
}

@end
