//
//  UserDetailViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/2.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserModel.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserDetailViewController ()

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *lbName;
@property (strong, nonatomic) UILabel *lbSign;
@property (strong, nonatomic) UILabel *lbDesc;
@property (strong, nonatomic) UILabel *lbNumQ;
@property (strong, nonatomic) UILabel *lbNumA;
@property (strong, nonatomic) UILabel *lbNumP;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.entity.name;
    [self setupViews];
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.5 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews {
    self.avatar = UIImageView.new;
    [self.view addSubview:self.avatar];
    self.lbName = UILabel.new;
    self.lbName.numberOfLines = 0;
    self.lbName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbName];
    self.lbSign = UILabel.new;
    self.lbSign.numberOfLines = 0;
    self.lbSign.textAlignment = NSTextAlignmentCenter;
    self.lbSign.layer.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.9 alpha:1].CGColor;
    self.lbSign.layer.cornerRadius = 6;
    self.lbSign.layer.masksToBounds = YES;
    [self.view addSubview:self.lbSign];
    self.lbDesc = UILabel.new;
    self.lbDesc.numberOfLines = 0;
    self.lbDesc.textColor = [UIColor lightTextColor];
    self.lbDesc.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbDesc];
    self.lbNumQ = UILabel.new;
    self.lbNumQ.numberOfLines = 0;
    self.lbNumQ.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbNumQ];
    self.lbNumA = UILabel.new;
    self.lbNumA.numberOfLines = 0;
    self.lbNumA.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbNumA];
    self.lbNumP = UILabel.new;
    self.lbNumP.numberOfLines = 0;
    self.lbNumP.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbNumP];
    
    NSURL *avatarUrl = [NSURL URLWithString:self.entity.avatar];
    if (avatarUrl) {
        [self.avatar sd_setImageWithURL:avatarUrl];
    }
    
    self.lbName.text = self.entity.name;
    self.lbSign.text = self.entity.signature;
    self.lbDesc.text = self.entity.userDescription;
    self.lbNumQ.text = [@(self.entity.detail.ask) stringValue];
    self.lbNumA.text = [@(self.entity.detail.answer) stringValue];
    self.lbNumP.text = [@(self.entity.detail.post) stringValue];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [self.lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(8);
        make.left.greaterThanOrEqualTo(self.view.mas_left).with.offset(8);
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-8);
    }];
    [self.lbSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.lbName.mas_bottom).with.offset(8);
        make.left.greaterThanOrEqualTo(self.view.mas_left).with.offset(8);
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-8);
    }];
    [self.lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.lbSign.mas_bottom).with.offset(8);
        make.left.greaterThanOrEqualTo(self.view.mas_left).with.offset(8);
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-8);
    }];
    [self.lbNumQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(8);
        make.right.equalTo(self.lbNumA.mas_left).with.offset(-8);
        make.width.equalTo(self.lbNumA);
        make.top.equalTo(self.lbDesc.mas_bottom).with.offset(8);
    }];
    [self.lbNumA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbNumQ);
        make.right.equalTo(self.lbNumP.mas_left).with.offset(-8);
        make.width.equalTo(self.lbNumP);
    }];
    [self.lbNumP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbNumA);
        make.right.equalTo(self.view.mas_right).with.offset(-8);
    }];
}

@end
