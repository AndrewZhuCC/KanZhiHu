//
//  Post.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (strong, nonatomic) NSDate *date;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *pic;
@property (assign, nonatomic) NSInteger publishtime;
@property (assign, nonatomic) NSInteger count;
@property (copy, nonatomic) NSString *excerpt;

@end
