//
//  UserDetail.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/7/29.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetail : NSObject

@property (assign, nonatomic) NSInteger ask;
@property (assign, nonatomic) NSInteger answer;
@property (assign, nonatomic) NSInteger post;

@property (assign, nonatomic) NSInteger agree;
@property (assign, nonatomic) NSInteger agreei;//1日赞同数增加
@property (copy, nonatomic) NSString *agreeiratio;//1日赞同数增幅
@property (assign, nonatomic) NSInteger agreeiw;//7日赞同数增加
@property (copy, nonatomic) NSString *agreeiratiow;//7日赞同数增幅
@property (assign, nonatomic) NSInteger ratio;//平均赞同

@property (assign, nonatomic) NSInteger followee;
@property (assign, nonatomic) NSInteger follower;
@property (assign, nonatomic) NSInteger followeri;
@property (copy, nonatomic) NSString *followiraio;
@property (assign, nonatomic) NSInteger followeriw;
@property (copy, nonatomic) NSString *followiratiow;

@property (assign, nonatomic) NSInteger thanks;
@property (assign, nonatomic) NSInteger tratio;

@property (assign, nonatomic) NSInteger fav;//收藏数
@property (assign, nonatomic) NSInteger fratio;//收藏/赞同比

@property (assign, nonatomic) NSInteger logs;//公共编辑数

@property (assign, nonatomic) NSInteger mostvote;
@property (copy, nonatomic) NSString *mostvotepercent;
@property (assign, nonatomic) NSInteger mostvote5;
@property (copy, nonatomic) NSString *mostvote5percent;
@property (assign, nonatomic) NSInteger mostvote10;
@property (copy, nonatomic) NSString *mostvote10percent;

@property (assign, nonatomic) NSInteger count10000;
@property (assign, nonatomic) NSInteger count5000;
@property (assign, nonatomic) NSInteger count2000;
@property (assign, nonatomic) NSInteger count1000;
@property (assign, nonatomic) NSInteger count500;
@property (assign, nonatomic) NSInteger count200;
@property (assign, nonatomic) NSInteger count100;

@end
