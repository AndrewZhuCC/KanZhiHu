//
//  SearchUserModel.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchUserModel : NSObject

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *userHash;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *signature;
@property (assign, nonatomic) NSInteger answer;
@property (assign, nonatomic) NSInteger agree;
@property (assign, nonatomic) NSInteger follower;

@end
