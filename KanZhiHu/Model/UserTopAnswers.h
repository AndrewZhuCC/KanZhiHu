//
//  UserTopAnswers.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserTopAnswers : NSObject <NSCopying>

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *link;
@property (assign, nonatomic) NSInteger agree;
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL ispost;

@end
