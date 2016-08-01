//
//  GetPostAnswersResult.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PostAnswer;

@interface GetPostAnswersResult : NSObject

@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSArray<PostAnswer *> *answers;

@end
