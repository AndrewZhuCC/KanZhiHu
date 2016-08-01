//
//  PostsViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/1.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "PostsViewController.h"

#import "GetPostsResult.h"
#import "Post.h"
#import "NetworkManager.h"
#import "PostsTableViewCell.h"
#import "PostsAnswersViewController.h"

#import <Masonry/Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <MBProgressHUD.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface PostsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *hud;

@property (copy, nonatomic) NSArray<Post *> *entitys;
@property (strong, nonatomic) GetPostsResult *result;
@property (strong, nonatomic) NSURLSessionDataTask *task;

@end

@implementation PostsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.entitys = NSArray.new;
    [self configureTableView];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [self.hud setRemoveFromSuperViewOnHide:NO];
    [self.hud hide:NO];
    
    self.shyNavBarManager.scrollView = self.tableView;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.title = @"Today";
    
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - 

- (void)configureTableView {
    _tableView = UITableView.new;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:PostsTableViewCell.class forCellReuseIdentifier:NSStringFromClass(PostsTableViewCell.class)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(PostsTableViewCell.class) forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PostsTableViewCell *myCell = (PostsTableViewCell *)cell;
    [myCell configureTemplateWithEntity:self.entitys[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *entity = self.entitys[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(PostsTableViewCell.class) configuration:^(id cell) {
        PostsTableViewCell *myCell = cell;
        [myCell configureTemplateWithEntity:entity];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PostsAnswersViewController *vc = PostsAnswersViewController.new;
    vc.post = self.entitys[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -

- (void)getEntitysFromKanZhiHu {
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = nil;
    self.hud.detailsLabelText = nil;
    [self.hud show:YES];
    
    __weak typeof(self) wself = self;
    self.task = [NetworkManager queryPostsWithSuccessBlock:^(GetPostsResult *result) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        sself.result = result;
        sself.entitys = result.posts;
        [sself.tableView reloadData];
    } fail:^(NSError *error, NSString *errorFromNet) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        sself.entitys = NSArray.new;
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

@end
