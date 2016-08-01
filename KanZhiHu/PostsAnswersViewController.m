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

#import "GetPostAnswersResult.h"
#import "PostAnswer.h"

#import <Masonry/Masonry.h>
#import <MBProgressHUD.h>
#import <UITableView+FDTemplateLayoutCell.h>

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
    self.tableView.sectionHeaderHeight = 30;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:PostAnswersTableViewCell.class forCellReuseIdentifier:NSStringFromClass(PostAnswersTableViewCell.class)];
    
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
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PostAnswer *entity = [[self.entitys objectForKey:self.keys[section]] firstObject];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UILabel *title = UILabel.new;
    title.textColor = [UIColor blackColor];
    title.backgroundColor = [UIColor clearColor];
    title.text = entity.title;
    [view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -

- (void)getEntitysFromKanZhiHu {
    __weak typeof(self) wself = self;
    self.task = [NetworkManager queryPostAnswersWithPost:self.post success:^(GetPostAnswersResult *result) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        sself.result = result;
        [sself calEntitysWithResult:result];
        [sself.tableView reloadData];
    } fail:^(NSError *error, NSString *errorFromNet) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
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
        NSLog(@"%@", answer.questionid);
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
