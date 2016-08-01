//
//  UserDetail.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetail : NSObject

@property (strong, nonatomic) NSNumber *ask;
@property (strong, nonatomic) NSNumber *answer;
@property (strong, nonatomic) NSNumber *post;

@property (strong, nonatomic) NSNumber *agree;
@property (strong, nonatomic) NSNumber *agreei;//1日赞同数增加
@property (copy, nonatomic) NSString *agreeiratio;//1日赞同数增幅
@property (strong, nonatomic) NSNumber *agreeiw;//7日赞同数增加
@property (copy, nonatomic) NSString *agreeiratiow;//7日赞同数增幅
@property (strong, nonatomic) NSNumber *ratio;//平均赞同

@property (strong, nonatomic) NSNumber *followee;
@property (strong, nonatomic) NSNumber *follower;
@property (strong, nonatomic) NSNumber *followeri;
@property (copy, nonatomic) NSString *followiraio;
@property (strong, nonatomic) NSNumber *followeriw;
@property (copy, nonatomic) NSString *followiratiow;

@property (strong, nonatomic) NSNumber *thanks;
@property (strong, nonatomic) NSNumber *tratio;

@property (strong, nonatomic) NSNumber *fav;//收藏数
@property (strong, nonatomic) NSNumber *fratio;//收藏/赞同比

@property (strong, nonatomic) NSNumber *logs;//公共编辑数

@property (strong, nonatomic) NSNumber *mostvote;
@property (copy, nonatomic) NSString *mostvotepercent;
@property (strong, nonatomic) NSNumber *mostvote5;
@property (copy, nonatomic) NSString *mostvote5percent;
@property (strong, nonatomic) NSNumber *mostvote10;
@property (copy, nonatomic) NSString *mostvote10percent;

@property (strong, nonatomic) NSNumber *count10000;
@property (strong, nonatomic) NSNumber *count5000;
@property (strong, nonatomic) NSNumber *count2000;
@property (strong, nonatomic) NSNumber *count1000;
@property (strong, nonatomic) NSNumber *count500;
@property (strong, nonatomic) NSNumber *count200;
@property (strong, nonatomic) NSNumber *count100;

@end
