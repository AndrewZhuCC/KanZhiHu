//
//  PostAnswersTableViewCell.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostAnswersTableViewCell.h"

#import "PostAnswer.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIImageView+CornerRadius.h>

@interface PostAnswersTableViewCell ()

@property (strong, nonatomic) UILabel *lbSummary;
@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *lbName;
@property (strong, nonatomic) UILabel *lbVote;

@end

@implementation PostAnswersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = self.contentView;
        contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _lbVote = UILabel.new;
        [_lbVote setBackgroundColor:[UIColor clearColor]];
        [_lbVote setTextColor:[UIColor lightGrayColor]];
        [_lbVote setTextAlignment:NSTextAlignmentRight];
        [_lbVote setFont:[UIFont systemFontOfSize:15]];
        
        _lbSummary = UILabel.new;
        [_lbSummary setBackgroundColor:[UIColor clearColor]];
        [_lbSummary setTextColor:[UIColor blackColor]];
        _lbSummary.numberOfLines = 0;
        
        _lbName = UILabel.new;
        [_lbName setBackgroundColor:[UIColor clearColor]];
        [_lbName setTextColor:[UIColor blackColor]];
        [_lbName setTextAlignment:NSTextAlignmentCenter];
        [_lbName setFont:[UIFont systemFontOfSize:15]];
        _lbName.numberOfLines = 0;
        
        _imgView = [[UIImageView alloc] initWithRoundingRectImageView];
        _imgView.contentMode = UIViewContentModeScaleToFill;
        
        [contentView addSubview:_imgView];
        [contentView addSubview:_lbSummary];
        [contentView addSubview:_lbVote];
        [contentView addSubview:_lbName];
    }
    return self;
}

#pragma mark - AutoLayout

- (void)prepareForReuse {
    self.lbName.text = nil;
    self.lbVote.text = nil;
    self.lbSummary.text = nil;
    self.imgView.image = nil;
    [super prepareForReuse];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
        make.left.equalTo(self.contentView).with.offset(5);
        make.centerY.equalTo(self.contentView).with.offset(-10);
        make.top.greaterThanOrEqualTo(self.contentView).with.offset(5);
    }];
    
    [self.lbSummary mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.left.equalTo(self.imgView.mas_right).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.bottom.equalTo(self.lbVote.mas_top).with.offset(-5);
    }];
    
    [self.lbName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.imgView);
        make.centerX.equalTo(self.imgView);
        make.top.equalTo(self.imgView.mas_bottom).with.offset(5);
        make.bottom.lessThanOrEqualTo(self.contentView).with.offset(-5);
    }];
    
    [self.lbVote mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self.contentView).with.offset(-5);
        make.right.equalTo(self.contentView).with.offset(-5);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureCellWithEntity:(PostAnswer *)entity {
    self.lbVote.text = [NSString stringWithFormat:@"%@", @(entity.vote)];
    self.lbName.text = entity.authorname;
    self.lbSummary.text = entity.summary;
    NSURL *url = [NSURL URLWithString:entity.avatar];
    if (url) {
        [self.imgView sd_setImageWithURL:url placeholderImage:nil];
    }
}

@end
