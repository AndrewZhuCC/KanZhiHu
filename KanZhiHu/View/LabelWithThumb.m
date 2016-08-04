//
//  LabelWithThumb.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "LabelWithThumb.h"

#import <Masonry.h>

@interface LabelWithThumb ()

@end

@implementation LabelWithThumb

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _thumb = UIImageView.new;
        _label = UILabel.new;
        _label.font = [UIFont systemFontOfSize:15];
        [self addSubview:_thumb];
        [self addSubview:_label];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [self.thumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.width.equalTo(self.mas_height);
        make.left.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.left.equalTo(self.thumb.mas_right).with.offset(1);
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.greaterThanOrEqualTo(self.mas_height);
    }];
    [super updateConstraints];
}

#pragma mark - Public

@end
