//
//  SearchUserTableViewCell.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "SearchUserTableViewCell.h"
#import "SearchUserModel.h"
#import "LabelWithThumb.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface SearchUserTableViewCell ()

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *lbName;
@property (strong, nonatomic) UILabel *lbSign;
@property (strong, nonatomic) LabelWithThumb *labelAnswer;
@property (strong, nonatomic) LabelWithThumb *labelAgree;
@property (strong, nonatomic) LabelWithThumb *labelFollower;

@end

@implementation SearchUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _avatar = UIImageView.new;
        _lbName = UILabel.new;
        _lbName.textAlignment = NSTextAlignmentCenter;
        _lbName.numberOfLines = 0;
        _lbSign = UILabel.new;
        _lbSign.numberOfLines = 0;
        _labelAnswer = LabelWithThumb.new;
        _labelAnswer.thumb.image = [UIImage imageNamed:@"answer"];
        _labelAgree = LabelWithThumb.new;
        _labelAgree.thumb.image = [UIImage imageNamed:@"agree"];
        _labelFollower = LabelWithThumb.new;
        _labelFollower.thumb.image = [UIImage imageNamed:@"follower"];
        [self.contentView addSubview:_avatar];
        [self.contentView addSubview:_lbName];
        [self.contentView addSubview:_lbSign];
        [self.contentView addSubview:_labelAnswer];
        [self.contentView addSubview:_labelAgree];
        [self.contentView addSubview:_labelFollower];
    }
    return self;
}

#pragma mark - Auto Layout

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.avatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(self.contentView).with.offset(8);
        make.centerY.equalTo(self.contentView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.left.equalTo(self.contentView).with.offset(8);
    }];
    [self.lbName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatar.mas_bottom).with.offset(5);
        make.centerX.equalTo(self.avatar);
        make.width.equalTo(self.avatar);
        make.bottom.lessThanOrEqualTo(self.contentView).with.offset(-8);
    }];
    [self.lbSign mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).with.offset(-10);
        make.left.equalTo(self.avatar.mas_right).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-8);
        make.top.greaterThanOrEqualTo(self.contentView).with.offset(8);
    }];
    [self.labelAnswer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSign.mas_bottom).with.offset(5);
        make.bottom.lessThanOrEqualTo(self.contentView).with.offset(-8);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.labelAgree.mas_left).with.offset(-15);
    }];
    [self.labelAgree mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labelAnswer);
        make.height.equalTo(self.labelAnswer);
        make.centerX.equalTo(self.lbSign);
    }];
    [self.labelFollower mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labelAnswer);
        make.height.equalTo(self.labelAnswer);
        make.left.equalTo(self.labelAgree.mas_right).with.offset(15);
    }];
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureWithEntity:(SearchUserModel *)entity {
    NSURL *url = [NSURL URLWithString:entity.avatar];
    if (url) {
        [self.avatar sd_setImageWithURL:url];
    }
    self.lbName.text = entity.name;
    self.lbSign.text = entity.signature;
    self.labelAnswer.label.text = [@(entity.answer) stringValue];
    self.labelAgree.label.text = [@(entity.agree) stringValue];
    self.labelFollower.label.text = [@(entity.follower) stringValue];
}

@end
