//
//  SearchUserResult.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "SearchUserResult.h"

#import <YYModel/YYModel.h>

@interface SearchUserResult () <YYModel>

@end

@implementation SearchUserResult

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"users":SearchUserModel.class};
}

@end
