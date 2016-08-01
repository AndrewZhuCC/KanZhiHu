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

typedef void(^GetPostsSuccess)(GetPostsResult *result);
typedef void(^GetPostAnswersSuccess)(GetPostAnswersResult *result);

typedef void(^GetFail)(NSError *error, NSString *errorFromNet);

@interface NetworkManager : NSObject

+ (void)queryPostsWithSuccessBlock:(GetPostsSuccess)success fail:(GetFail)fail;
+ (void)queryPostAnswersWithPost:(Post *)post success:(GetPostAnswersSuccess)success fail:(GetFail)fail;

@end
