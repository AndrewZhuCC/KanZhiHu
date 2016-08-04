//
//  SearchUserModel.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "SearchUserModel.h"

#import <YYModel/YYModel.h>

@interface SearchUserModel () <YYModel>

@end

@implementation SearchUserModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"userId":@"id", @"userHash":@"hash"};
}

@end
