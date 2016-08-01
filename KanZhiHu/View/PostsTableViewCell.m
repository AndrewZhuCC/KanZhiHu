//
//  PostsTableViewCell.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostsTableViewCell.h"
#import "Post.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>

#define ImageW_HScale 2.0

@interface PostsTableViewCell ()

@property (strong, nonatomic) UILabel *lbDate;
@property (strong, nonatomic) UILabel *lbexcerpt;
@property (strong, nonatomic) UILabel *lbAnswerCount;
@property (readwrite, strong, nonatomic) UIImageView *imgView;

@property (assign, nonatomic, getter=isTemplate) BOOL template;


@end

@implementation PostsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *contentView = self.contentView;
        contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        _lbDate = UILabel.new;
        [_lbDate setBackgroundColor:[UIColor clearColor]];
        [_lbDate setTextColor:[UIColor lightGrayColor]];
        
        _lbexcerpt = UILabel.new;
        [_lbexcerpt setBackgroundColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.7 alpha:0.3]];
        [_lbexcerpt setTextColor:[UIColor blackColor]];
        _lbexcerpt.layer.cornerRadius = 5;
        _lbexcerpt.layer.masksToBounds = YES;
        _lbexcerpt.layoutMargins = UIEdgeInsetsMake(5, 5, 5, 5);
        _lbexcerpt.numberOfLines = 0;
        
        _lbAnswerCount = UILabel.new;
        [_lbAnswerCount setBackgroundColor:[UIColor clearColor]];
        [_lbAnswerCount setTextColor:[UIColor lightTextColor]];
        
        _imgView = UIImageView.new;
        _imgView.contentMode = UIViewContentModeScaleToFill;
        
        [contentView addSubview:_imgView];
        [contentView addSubview:_lbDate];
        [contentView addSubview:_lbAnswerCount];
        [contentView addSubview:_lbexcerpt];
    }
    return self;
}

#pragma mark - AutoLayout

- (void)prepareForReuse {
    self.lbDate.text = nil;
    self.lbexcerpt.text = nil;
    self.lbAnswerCount.text = nil;
    self.imgView.image = nil;
    [super prepareForReuse];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    CGFloat imageHeight = (UIScreen.mainScreen.bounds.size.width - 10) / ImageW_HScale;
    [self.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(imageHeight));
        make.top.equalTo(self.contentView).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-5);
    }];
    
    [self.lbexcerpt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(5);
        make.left.equalTo(self.contentView).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.bottom.equalTo(self.contentView).with.offset(-5);
    }];
    
    [self.lbDate mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.right.equalTo(self.imgView.mas_right).with.offset(-10);
        make.bottom.equalTo(self.imgView.mas_bottom).with.offset(-5);
    }];
    
    [self.lbAnswerCount mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.right.equalTo(self.lbDate.mas_left).with.offset(-5);
        make.centerY.equalTo(self.lbDate);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureTemplateWithEntity:(Post *)post {
    self.lbexcerpt.text = [[post.excerpt stringByReplacingOccurrencesOfString:@"』、" withString:@"』\n"] stringByReplacingOccurrencesOfString:@"摘录了" withString:@"摘录了\n"];
    self.lbAnswerCount.text = [NSString stringWithFormat:@"%@", @(post.count)];
    NSDateFormatter *formatter = NSDateFormatter.new;
    [formatter setDateFormat:@"'Publish at 'yyyy-MM-dd"];
    self.lbDate.text = [formatter stringFromDate:post.date];
    
    __weak typeof(self) wself = self;
    NSURL *imgUrl = [NSURL URLWithString:post.pic];
    if (imgUrl) {
        [self.imgView sd_setImageWithURL:imgUrl placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            typeof(wself) sself = wself;
            if (image && sself) {
//                [sself updateConstraints];
            } else {
                NSLog(@"download image:%@, error:%@", imageURL, error);
            }
        }];
    }
}

@end
