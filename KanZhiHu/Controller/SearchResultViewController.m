//
//  SearchResultViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/3.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "SearchResultViewController.h"

#import "NetworkManager.h"
#import "SearchUserResult.h"
#import "SearchUserTableViewCell.h"
#import "UserDetailViewController.h"

#import <Masonry/Masonry.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <MBProgressHUD.h>
#import <TLYShyNavBar/TLYShyNavBarManager.h>

@interface SearchResultViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MBProgressHUD *hud;

@property (copy, nonatomic) NSArray<SearchUserModel *> *searchEntitys;
@property (strong, nonatomic) SearchUserResult *searchResult;

@property (strong, nonatomic) NSURLSessionDataTask *task;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureTableView];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    [self.hud setRemoveFromSuperViewOnHide:NO];
    [self.hud hide:NO];
//    self.shyNavBarManager.scrollView = self.tableView;
    
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.task.state == NSURLSessionTaskStateRunning) {
        [self.task cancel];
        self.task = nil;
    }
    
    [self.hud hide:NO];
    NSLog(@"%s", __func__);
}

#pragma mark - TableView

- (void)configureTableView {
    _tableView = UITableView.new;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:SearchUserTableViewCell.class forCellReuseIdentifier:NSStringFromClass(SearchUserTableViewCell.class)];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchEntitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(SearchUserTableViewCell.class) forIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchUserTableViewCell *myCell = (SearchUserTableViewCell *)cell;
    [myCell configureWithEntity:self.searchEntitys[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchUserModel *entity = self.searchEntitys[indexPath.row];
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass(SearchUserTableViewCell.class) configuration:^(id cell) {
        SearchUserTableViewCell *myCell = cell;
        [myCell configureWithEntity:entity];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self showHud];
    
    NSString *userHash = self.searchEntitys[indexPath.row].userHash;
        
    [NetworkManager queryUserDetailWithUserHash:userHash success:^(UserModel *result) {
        UserDetailViewController *vc = UserDetailViewController.new;
        vc.entity = result;
        vc.userHash = userHash;
        [self.navToPushUserVC pushViewController:vc animated:YES];
    } fail:^(NSError *error, NSString *errorFromNet) {
        [self.hud hide:NO];
        if (error) {
            [self showHudWithTitle:error.domain message:error.localizedDescription];
        } else {
            [self showHudWithTitle:@"error" message:errorFromNet];
        }
    }];
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

- (void)searchUsersWithKeyword:(NSString *)word {
    [self showHud];
    
    __weak typeof(self) wself = self;
    self.task = [NetworkManager searchUserWithWord:word success:^(SearchUserResult *result) {
        typeof(wself) sself = wself;
        [sself.hud hide:YES];
        self.searchResult = result;
        self.searchEntitys = result.users;
        [sself.tableView reloadData];
    } fail:^(NSError *error, NSString *errorFromNet) {
        typeof(wself) sself = wself;
        [sself.hud hide:NO];
        self.searchResult = nil;
        self.searchEntitys = nil;
        if (error) {
            if (error.code != -999) {
                [sself showHudWithTitle:error.domain message:error.localizedDescription];
            }
        } else {
            [sself showHudWithTitle:@"Error" message:errorFromNet];
        }
    }];
}

@end
