//
//  TopAnswersTableViewCell.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/2.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "TopAnswersTableViewCell.h"
#import "UserModel.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TopAnswersTableViewCell ()

@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) UILabel *lbDate;
@property (strong, nonatomic) UILabel *lbVotes;
@property (strong, nonatomic) UIImageView *imgThumb;

@end

@implementation TopAnswersTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"orange"]];
        self.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
        _lbTitle = UILabel.new;
        _lbTitle.numberOfLines = 0;
        
        _lbDate = UILabel.new;
        _lbDate.numberOfLines = 1;
        _lbDate.font = [UIFont systemFontOfSize:14];
        _lbDate.textColor = [UIColor lightTextColor];
        _lbDate.textAlignment = NSTextAlignmentRight;
        
        _lbVotes = UILabel.new;
        _lbVotes.numberOfLines = 1;
        _lbVotes.font = [UIFont systemFontOfSize:14];
        
        _imgThumb = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thumb"]];
        
        [self.contentView addSubview:_lbTitle];
        [self.contentView addSubview:_lbDate];
        [self.contentView addSubview:_lbVotes];
        [self.contentView addSubview:_imgThumb];
    }
    return self;
}

#pragma mark - AutoLayout

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)prepareForReuse {
    self.lbTitle.text = nil;
    self.lbDate.text = nil;
    self.lbVotes.text = nil;
    
    [super prepareForReuse];
}

- (void)updateConstraints {
    [self.lbTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbVotes.mas_right).with.offset(8);
        make.right.equalTo(self.contentView).with.offset(-10);
        make.top.equalTo(self.contentView).with.offset(10);
    }];
    
    [self.lbDate mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom).with.offset(8);
        make.right.equalTo(self.lbTitle);
        make.bottom.equalTo(self.contentView).with.offset(-10);
    }];
    
    [self.lbVotes mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.imgThumb.mas_right).with.offset(1);
        make.width.mas_equalTo(40);
    }];
    
    [self.imgThumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureCellWithEntity:(UserTopAnswers *)entity {
    self.lbTitle.text = entity.title;
    NSDateFormatter *formatter = NSDateFormatter.new;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    self.lbDate.text = [formatter stringFromDate:entity.date];
    self.lbVotes.text = [@(entity.agree) stringValue];
}

@end
