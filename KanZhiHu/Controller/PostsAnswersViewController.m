//
//  PostsAnswersViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostsAnswersViewController.h"

#import "Post.h"
#import "NetworkManager.h"
#import "PostAnswersTableViewCell.h"
#import "UserDetailViewController.h"
#import "WebViewController.h"

#import "GetPostAnswersResult.h"
#import "PostAnswer.h"
#import "UserModel.h"

#import <Masonry/Masonry.h>
#import <MBProgressHUD.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import <MJRefresh.h>

#define ZHIHU_URL @"https://www.zhihu.com/question"
#define ZHIHU_APP_URL @"zhihu://"

@interface PostsAnswersViewController () <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSDictionary<NSString *, NSArray<PostAnswer *> *> *entitys;
@property (copy, nonatomic) NSArray *keys;
@property (strong, nonatomic) GetPostAnswersResult *result;
@property (strong, nonatomic) NSURLSessionDataTask *task;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation PostsAnswersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.keys = NSArray.new;
    self.entitys = NSDictionary.new;
    [self configureTableView];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [self.hud setRemoveFromSuperViewOnHide:NO];
    [self.hud hide:NO];
    
    self.shyNavBarManager.scrollView = self.tableView;
    
    NSDateFormatter *formatter = NSDateFormatter.new;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.title = [formatter stringFromDate:self.post.date];
    
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.entitys || !self.result) {
        [self getEntitysFromKanZhiHu];
    }
    NSLog(@"%s", __func__);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
        self.task = nil;
    }
    
    [self.hud hide:NO];
    [self.tableView.mj_header endRefreshing];
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)configureTableView {
    _tableView = UITableView.new;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:PostAnswersTableViewCell.class forCellReuseIdentifier:NSStringFromClass(PostAnswersTableViewCell.class)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getEntitysFromKanZhiHu)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.entitys objectForKey:self.keys[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PostAnswersTableViewCell.class) forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostAnswersTableViewCell *myCell = (PostAnswersTableViewCell *)cell;
    [myCell configureCellWithEntity:[self.entitys objectForKey:self.keys[indexPath.section]][indexPath.row]];
    
    PostAnswer *entity = [self.entitys objectForKey:self.keys[indexPath.section]][indexPath.row];
    __weak typeof(self) wself = self;
    
    [myCell setAvatarClick:^(PostAnswersTableViewCell *cell) {
        typeof(wself) sself = wself;
        sself.hud.mode = MBProgressHUDModeIndeterminate;
        sself.hud.labelText = nil;
        sself.hud.detailsLabelText = nil;
        [sself.hud show:YES];
        
        [NetworkManager queryUserDetailWithUserHash:entity.authorhash success:^(UserModel *result) {
            UserDetailViewController *vc = UserDetailViewController.new;
            vc.entity = result;
            vc.userHash = entity.authorhash;
            [sself.navigationController pushViewController:vc animated:YES];
        } fail:^(NSError *error, NSString *errorFromNet) {
            [sself.tableView.mj_header endRefreshing];
            [sself.hud hide:NO];
            sself.hud.mode = MBProgressHUDModeText;
            if (error) {
                sself.hud.labelText = error.domain;
                sself.hud.detailsLabelText = error.localizedDescription;
            } else {
                sself.hud.labelText = @"error";
                sself.hud.detailsLabelText = errorFromNet;
            }
            [sself.hud show:YES];
            [sself.hud hide:YES afterDelay:3];
        }];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostAnswer *entity = [[self.entitys objectForKey:self.keys[section]] firstObject];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    view.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.5 alpha:1].CGColor;
    view.layer.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:1 alpha:1.0].CGColor;
    view.layer.borderWidth = 2;
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    
    UILabel *title = UILabel.new;
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.text = entity.title;
    title.numberOfLines = 0;
    [view addSubview:title];
    
    UIButton *backButton = UIButton.new;
    backButton.tag = section;
    [backButton addTarget:self action:@selector(tableViewHeaderTapped:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostAnswer *entity = [self.entitys objectForKey:self.keys[indexPath.section]][indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(PostAnswersTableViewCell.class) configuration:^(id cell) {
        PostAnswersTableViewCell *myCell = cell;
        [myCell configureCellWithEntity:entity];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PostAnswer *entity = [[self.entitys objectForKey:self.keys[section]] firstObject];
    UILabel *title = UILabel.new;
    title.numberOfLines = 0;
    title.text = entity.title;
    CGSize size = [title systemLayoutSizeFittingSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width - 10, CGFLOAT_MAX)];
    return size.height + 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PostAnswer *entity = [self.entitys objectForKey:self.keys[indexPath.section]][indexPath.row];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jumpToZhiHu"]) {
        NSString *zhihuAnswerURLS = [NSString stringWithFormat:@"%@answers/%@", ZHIHU_APP_URL, entity.answerid];
        //    NSString *zhihuapp = [ZHIHU_APP_URL stringByAppendingPathComponent:entity.answerid];
        NSURL *url = [NSURL URLWithString:zhihuAnswerURLS];
        NSLog(@"%@", url);
        if (url) {
            [UIApplication.sharedApplication openURL:url];
        }
    } else {
        WebViewController *webVC = WebViewController.new;
        NSString *webUrlS = [NSString stringWithFormat:@"https://www.zhihu.com/question/%@/answer/%@", entity.questionid, entity.answerid];
        NSURL *url = [NSURL URLWithString:webUrlS];
        if (url) {
            webVC.urlToLoad = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}

- (void)tableViewHeaderTapped:(UIButton *)button {
    PostAnswer *entity = [self.entitys objectForKey:self.keys[button.tag]][0];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jumpToZhiHu"]) {
        NSString *zhihuAnswerURLS = [NSString stringWithFormat:@"%@questions/%@", ZHIHU_APP_URL, entity.questionid];
        //    NSString *zhihuapp = [ZHIHU_APP_URL stringByAppendingPathComponent:entity.answerid];
        NSURL *url = [NSURL URLWithString:zhihuAnswerURLS];
        NSLog(@"%@", url);
        if (url) {
            [UIApplication.sharedApplication openURL:url];
        }
    } else {
        WebViewController *webVC = WebViewController.new;
        NSString *webUrlS = [NSString stringWithFormat:@"https://www.zhihu.com/question/%@", entity.questionid];
        NSURL *url = [NSURL URLWithString:webUrlS];
        if (url) {
            webVC.urlToLoad = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}

#pragma mark -

- (void)getEntitysFromKanZhiHu {
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = nil;
    self.hud.detailsLabelText = nil;
    [self.hud show:YES];
    
    __weak typeof(self) wself = self;
    self.task = [NetworkManager queryPostAnswersWithPost:self.post success:^(GetPostAnswersResult *result) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        [sself.tableView.mj_header endRefreshing];
        sself.result = result;
        [sself calEntitysWithResult:result];
        [sself.tableView reloadData];
    } fail:^(NSError *error, NSString *errorFromNet) {
        typeof(wself) sself = wself;
        [sself.hud hide:NO];
        [sself.tableView.mj_header endRefreshing];
        sself.entitys = NSDictionary.new;
        sself.keys = NSArray.new;
        sself.result = nil;
        [sself.tableView reloadData];
        if (error) {
            if (error.code != -999) {
                sself.hud.mode = MBProgressHUDModeText;
                sself.hud.labelText = error.domain;
                sself.hud.detailsLabelText = error.localizedDescription;
                [sself.hud show:YES];
                [sself.hud hide:YES afterDelay:3];
            }
        }
    }];
}

- (void)calEntitysWithResult:(GetPostAnswersResult *)result {
    NSMutableDictionary *dic = NSMutableDictionary.new;
    for (PostAnswer *answer in result.answers) {
        NSMutableArray *ary = [dic objectForKey:answer.questionid];
        if (!ary) {
            ary = NSMutableArray.new;
            [dic setObject:ary forKey:answer.questionid];
        }
        [ary addObject:answer];
    }
    self.entitys = [dic copy];
    self.keys = dic.allKeys;
}

@end