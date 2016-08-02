//
//  UserDescTableViewCell.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/2.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserDescTableViewCell.h"
#import "UserModel.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserDescTableViewCell()

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *lbSign;
@property (strong, nonatomic) UILabel *lbDesc;
@property (strong, nonatomic) UILabel *lbNumQ;
@property (strong, nonatomic) UILabel *lbNumA;
@property (strong, nonatomic) UILabel *lbNumP;
@property (strong, nonatomic) UIImageView *imgQ;
@property (strong, nonatomic) UIImageView *imgA;
@property (strong, nonatomic) UIImageView *imgP;

@property (strong, nonatomic) NSNumber *redBase;
@property (strong, nonatomic) NSNumber *greenBase;
@property (strong, nonatomic) NSNumber *blueBase;

@end

@implementation UserDescTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = self.contentView;
//        contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.5 alpha:1];
        contentView.backgroundColor = [self userBackgroundColor];
        _avatar = UIImageView.new;
        [contentView addSubview:_avatar];
        
        _lbSign = UILabel.new;
        _lbSign.numberOfLines = 0;
        _lbSign.textAlignment = NSTextAlignmentCenter;
        _lbSign.textColor = [self qapColor];
        [contentView addSubview:_lbSign];
        
        _lbDesc = UILabel.new;
        _lbDesc.numberOfLines = 0;
//        _lbDesc.textColor = [UIColor lightTextColor];
        _lbDesc.textColor = [self descColor];
        _lbDesc.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:_lbDesc];
        
        _lbNumQ = UILabel.new;
        _lbNumQ.numberOfLines = 0;
        _lbNumQ.textAlignment = NSTextAlignmentCenter;
        _lbNumQ.textColor = [self qapColor];
        [contentView addSubview:_lbNumQ];
        
        _imgQ = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"question"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _imgQ.tintColor = [self qapColor];
        [contentView addSubview:_imgQ];
        
        _lbNumA = UILabel.new;
        _lbNumA.numberOfLines = 0;
        _lbNumA.textAlignment = NSTextAlignmentCenter;
        _lbNumA.textColor = [self qapColor];
        [contentView addSubview:_lbNumA];
        
        _imgA = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"answer"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _imgA.tintColor = [self qapColor];
        [contentView addSubview:_imgA];
        
        _lbNumP = UILabel.new;
        _lbNumP.numberOfLines = 0;
        _lbNumP.textAlignment = NSTextAlignmentCenter;
        _lbNumP.textColor = [self qapColor];
        [contentView addSubview:_lbNumP];
        
        _imgP = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"post"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _imgP.tintColor = [self qapColor];
        [contentView addSubview:_imgP];
    }
    return self;
}

#pragma mark - AutoLayout

- (void)prepareForReuse {
    self.lbSign.text = nil;
    self.lbDesc.text = nil;
    self.lbNumQ.text = nil;
    self.lbNumA.text = nil;
    self.lbNumP.text = nil;
    self.avatar.image = nil;
    [super prepareForReuse];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.avatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [self.lbSign mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.avatar.mas_bottom).with.offset(8);
        make.left.greaterThanOrEqualTo(self.contentView.mas_left).with.offset(8);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-8);
    }];
    [self.lbDesc mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.lbSign.mas_bottom).with.offset(8);
        make.left.greaterThanOrEqualTo(self.contentView.mas_left).with.offset(8);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).with.offset(-8);
    }];
    [self.lbNumQ mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgQ.mas_right).with.offset(1);
        make.right.equalTo(self.imgA.mas_left).with.offset(-30);
        make.top.equalTo(self.lbDesc.mas_bottom).with.offset(8);
        make.bottom.equalTo(self.contentView).with.offset(-8);
    }];
    [self.imgQ mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.lbNumQ).with.offset(-2);
    }];
    [self.lbNumA mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbNumQ);
        make.left.equalTo(self.imgA.mas_right).with.offset(1);
        make.right.equalTo(self.imgP.mas_left).with.offset(-30);
    }];
    [self.imgA mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.lbNumA);
    }];
    [self.lbNumP mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbNumA);
        make.left.equalTo(self.imgP.mas_right).with.offset(1);
    }];
    [self.imgP mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.lbNumP);
    }];
    [super updateConstraints];
}

- (NSNumber *)redBase {
    if (!_redBase) {
        _redBase = @(arc4random() % 255);
    }
    return _redBase;
}

- (NSNumber *)greenBase {
    if (!_greenBase) {
        _greenBase = @(arc4random() % 255);
    }
    return _greenBase;
}

- (NSNumber *)blueBase {
    if (!_blueBase) {
        _blueBase = @(arc4random() % 255);
    }
    return _blueBase;
}

- (UIColor *)userBackgroundColor {
    return [UIColor colorWithRed:[self.redBase integerValue] / 255.0 green:[self.greenBase integerValue] / 255.0 blue:[self.blueBase integerValue] / 255.0 alpha:1.0];
}

- (UIColor *)qapColor {
    return [UIColor colorWithRed:1.0 - [self.redBase integerValue] / 255.0 green:1.0 - [self.greenBase integerValue] / 255.0 blue:[self.blueBase integerValue] / 255.0 alpha:1.0];
}

- (UIColor *)descColor {
    return [UIColor colorWithRed:1.0 - [self.redBase integerValue] / 255.0 green:1.0 - [self.greenBase integerValue] / 255.0 blue:1.0 - [self.blueBase integerValue] / 255.0 alpha:1.0];
}

#pragma mark - Public Methods

- (void)configureCellWithEntity:(UserModel *)entity {
    NSURL *avatarUrl = [NSURL URLWithString:entity.avatar];
    if (avatarUrl) {
        [self.avatar sd_setImageWithURL:avatarUrl];
    }
    
    self.lbSign.text = entity.signature;
    self.lbDesc.text = entity.userDescription;
    self.lbNumQ.text = [@(entity.detail.ask) stringValue];
    self.lbNumA.text = [@(entity.detail.answer) stringValue];
    self.lbNumP.text = [@(entity.detail.post) stringValue];
}

@end
