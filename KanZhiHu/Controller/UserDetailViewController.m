//
//  UserDetailViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/2.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "UserDetailViewController.h"
#import "UserDescTableViewCell.h"
#import "TopAnswersTableViewCell.h"
#import "UserModel.h"

#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UITableView+FDTemplateLayoutCell.h>

@interface UserDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation UserDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.entity.name;
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.8 blue:0.5 alpha:1];
    [self configureTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (void)configureTableView {
    _tableView = UITableView.new;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:UserDescTableViewCell.class forCellReuseIdentifier:NSStringFromClass(UserDescTableViewCell.class)];
    [self.tableView registerClass:TopAnswersTableViewCell.class forCellReuseIdentifier:NSStringFromClass(TopAnswersTableViewCell.class)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? 1 : self.entity.topanswers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UserDescTableViewCell.class) forIndexPath:indexPath];
            break;
    
        case 1:
        default:
            return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(TopAnswersTableViewCell.class) forIndexPath:indexPath];
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UserDescTableViewCell *myCell = (UserDescTableViewCell *)cell;
            [myCell configureCellWithEntity:self.entity];
        }
            break;
            
        case 1:
        default:
        {
            TopAnswersTableViewCell *myCell = (TopAnswersTableViewCell *)cell;
            [myCell configureCellWithEntity:self.entity.topanswers[indexPath.row]];
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSURL *url = nil;
    if (indexPath.section == 1) {
        NSString *answerUrl = self.entity.topanswers[indexPath.row].link;
        if (self.entity.topanswers[indexPath.row].ispost) {
            NSRange answerRange = NSMakeRange(3, answerUrl.length - 3);
            if (answerRange.length + answerRange.location > answerUrl.length) {
                answerUrl = nil;
            } else {
                answerUrl = [answerUrl substringWithRange:answerRange];
                answerUrl = [NSString stringWithFormat:@"zhihu://zhuanlan/%@", answerUrl];
            }
        } else {
            NSRange answerRange = [answerUrl rangeOfString:@"answer"];
            if (answerRange.location != NSNotFound) {
                answerRange.length = answerUrl.length - answerRange.location - 6;
                answerRange.location += 6;
                answerUrl = [answerUrl substringWithRange:answerRange];
                answerUrl = [NSString stringWithFormat:@"zhihu://answers%@", answerUrl];
            } else {
                answerUrl = nil;
            }
        }
        url = [NSURL URLWithString:answerUrl];
    } else {
        if (self.userHash.length > 0) {
            NSString *peopleUrl = [NSString stringWithFormat:@"zhihu://people/%@", self.userHash];
            url = [NSURL URLWithString:peopleUrl];
        }
    }
    if (url) {
        [UIApplication.sharedApplication openURL:url];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UserModel *entity = self.entity;
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(UserDescTableViewCell.class) configuration:^(id cell) {
                UserDescTableViewCell *myCell = (UserDescTableViewCell *)cell;
                [myCell configureCellWithEntity:entity];
            }];
        }
            break;
        case 1:
        default:
        {
            UserTopAnswers *entity = self.entity.topanswers[indexPath.row];
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(TopAnswersTableViewCell.class) configuration:^(id cell) {
                TopAnswersTableViewCell *myCell = (TopAnswersTableViewCell *)cell;
                [myCell configureCellWithEntity:entity];
            }];
        }
    }
}

@end
