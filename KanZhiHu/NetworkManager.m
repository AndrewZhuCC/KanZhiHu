//
//  NetworkManager.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#define URL_GETPOSTS @"http://api.kanzhihu.com/getposts"
#define URL_GETPOSTANSWERS @"http://api.kanzhihu.com/getpostanswers"
#define URL_GETUSERDETAIL @"http://api.kanzhihu.com/userdetail2"

#import "NetworkManager.h"
#import "GetPostsResult.h"
#import "Post.h"
#import "UserModel.h"

#import "GetPostAnswersResult.h"
#import "PostAnswer.h"

#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>

@implementation NetworkManager

+ (NSURLSessionDataTask *)queryPostsWithSuccessBlock:(GetPostsSuccess)success fail:(GetFail)fail {
    return [AFHTTPSessionManager.manager GET:URL_GETPOSTS parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"error"] isEqualToString:@""]) {
            GetPostsResult *result = [GetPostsResult yy_modelWithJSON:responseObject];
            success(result);
        } else {
            NSString *error = [responseObject objectForKey:@"error"];
            fail(nil, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error, nil);
    }];
}

+ (NSURLSessionDataTask *)queryPostAnswersWithPost:(Post *)post success:(GetPostAnswersSuccess)success fail:(GetFail)fail {
    return [AFHTTPSessionManager.manager GET:[self getPostAnswersURLWithPost:post] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"error"] isEqualToString:@""]) {
            GetPostAnswersResult *result = [GetPostAnswersResult yy_modelWithJSON:responseObject];
            success(result);
        } else {
            NSString *error = [responseObject objectForKey:@"error"];
            fail(nil, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error, nil);
    }];
}

+ (NSURLSessionDataTask *)queryUserDetailWithUserHash:(NSString *)hash success:(GetUserDetailSuccess)success fail:(GetFail)fail {
    return [AFHTTPSessionManager.manager GET:[URL_GETUSERDETAIL stringByAppendingPathComponent:hash] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"error"] isEqualToString:@""]) {
            UserModel *result = [UserModel yy_modelWithJSON:responseObject];
            success(result);
        } else {
            NSString *error = [responseObject objectForKey:@"error"];
            fail(nil, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error, nil);
    }];
}

#pragma mark - Tools

+ (NSString *)getPostAnswersURLWithPost:(Post *)post {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *strDate = [formatter stringFromDate:post.date];
    return [[URL_GETPOSTANSWERS stringByAppendingPathComponent:strDate] stringByAppendingPathComponent:post.name];
}

@end
