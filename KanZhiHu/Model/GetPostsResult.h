//
//  GetPostsResult.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Post;

@interface GetPostsResult : NSObject

@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSArray<Post *> *posts;

@end
