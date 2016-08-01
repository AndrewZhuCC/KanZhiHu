//
//  UserModel.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

#import "UserDetail.h"
#import "UserStar.h"
#import "UserTrend.h"
#import "UserTopAnswers.h"

@interface UserModel : NSObject <YYModel>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *signature;
@property (copy, nonatomic) NSString *userDescription;
@property (strong, nonatomic) UserDetail *detail;
@property (strong, nonatomic) UserStar *star;
@property (copy, nonatomic) NSArray<UserTrend *> *trend;
@property (copy, nonatomic) NSArray<UserTopAnswers *> *topanswers;

@end
