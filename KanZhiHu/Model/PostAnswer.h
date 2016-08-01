//
//  PostAnswer.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostAnswer : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *time;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *questionid;
@property (copy, nonatomic) NSString *answerid;
@property (copy, nonatomic) NSString *authorhash;
@property (copy, nonatomic) NSString *avatar;
@property (assign, nonatomic) NSInteger vote;

@end
