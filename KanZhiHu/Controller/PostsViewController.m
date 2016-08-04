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
#import "SearchResultViewController.h"

#import <Masonry/Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <MBProgressHUD.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import <MJRefresh.h>

@interface PostsViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *hud;

@property (copy, nonatomic) NSArray<Post *> *entitys;
@property (strong, nonatomic) GetPostsResult *result;

@property (strong, nonatomic) NSURLSessionDataTask *task;

@property (strong, nonatomic) SearchResultViewController *searchResultViewController;
@property (assign, nonatomic) BOOL searching;


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
    
    self.searchResultViewController = SearchResultViewController.new;
    [self.view addSubview:self.searchResultViewController.view];
    [self.searchResultViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.mas_offset(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.searchResultViewController.view.hidden = YES;
    UISearchBar *searchBar = UISearchBar.new;
    searchBar.delegate = self;
    [searchBar setImage:[[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    searchBar.tintColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = searchBar;
    
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
    [self.tableView.mj_header endRefreshing];
    NSLog(@"%s", __func__);
}

#pragma mark - Search Bar

- (void)searchBarCancel:(UISearchBar *)searchBar {
    self.searching = NO;
    [searchBar endEditing:YES];
    searchBar.showsBookmarkButton = NO;
    searchBar.text = nil;
    [UIView transitionFromView:self.searchResultViewController.view toView:self.tableView duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
        if (finished) {
            [self.searchResultViewController viewDidDisappear:YES];
        }
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s", __func__);
    [searchBar endEditing:YES];
    [self.searchResultViewController searchUsersWithKeyword:searchBar.text];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    [self searchBarCancel:searchBar];
    NSLog(@"%s", __func__);
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [[self.view viewWithTag:225] removeFromSuperview];
    if (searchBar.text.length == 0) {
        [self searchBarCancel:searchBar];
    }
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"%s", __func__);
    self.searching = YES;
    searchBar.showsBookmarkButton = YES;
    UIButton *backButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    backButton.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    backButton.tag = 225;
    backButton.alpha = 0;
    [self.view addSubview:backButton];
    [UIView transitionFromView:self.tableView toView:self.searchResultViewController.view duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finished) {
    }];
    backButton.alpha = 1;
    return YES;
}

- (void)backButtonTapped:(UIButton *)button {
    [self.navigationItem.titleView endEditing:NO];
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
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getEntitysFromKanZhiHu)];
    
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

- (void)showHud {
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = nil;
    self.hud.detailsLabelText = nil;
    [self.hud show:YES];
}

- (void)showHudWithTitle:(NSString *)title message:(NSString *)message {
    self.hud.mode = MBProgressHUDModeText;
    self.hud.labelText = title;
    self.hud.detailsLabelText = message;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:3];
}

- (void)getEntitysFromKanZhiHu {
    [self showHud];
    
    __weak typeof(self) wself = self;
    self.task = [NetworkManager queryPostsWithSuccessBlock:^(GetPostsResult *result) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        [sself.tableView.mj_header endRefreshing];
        sself.result = result;
        sself.entitys = result.posts;
        [sself.tableView reloadData];
    } fail:^(NSError *error, NSString *errorFromNet) {
        typeof(wself) sself = wself;
        [sself.hud hide:NO];
        [sself.tableView.mj_header endRefreshing];
        sself.entitys = NSArray.new;
        sself.result = nil;
        [sself.tableView reloadData];
        if (error) {
            if (error.code != -999) {
                [sself showHudWithTitle:error.domain message:error.localizedDescription];
            }
        }
    }];
}

@end
