//
//  PostsTableViewCell.h
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

typedef void(^DownloadImageCompletion)(UIImage *image, NSError *error);

@interface PostsTableViewCell : UITableViewCell

@property (readonly, strong, nonatomic) UIImageView *imgView;

- (void)configureTemplateWithEntity:(Post *)post;

@end
