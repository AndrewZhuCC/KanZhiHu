//
//  NetworkManager.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetPostsResult;
@class GetPostAnswersResult;
@class Post;
@class UserModel;

typedef void(^GetPostsSuccess)(GetPostsResult *result);
typedef void(^GetPostAnswersSuccess)(GetPostAnswersResult *result);
typedef void(^GetUserDetailSuccess)(UserModel *result);

typedef void(^GetFail)(NSError *error, NSString *errorFromNet);

@interface NetworkManager : NSObject

+ (NSURLSessionDataTask *)queryPostsWithSuccessBlock:(GetPostsSuccess)success fail:(GetFail)fail;
+ (NSURLSessionDataTask *)queryPostAnswersWithPost:(Post *)post success:(GetPostAnswersSuccess)success fail:(GetFail)fail;
+ (NSURLSessionDataTask *)queryUserDetailWithUserHash:(NSString *)hash success:(GetUserDetailSuccess)success fail:(GetFail)fail;

@end
