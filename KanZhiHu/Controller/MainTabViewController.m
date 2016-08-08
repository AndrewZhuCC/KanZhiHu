//
//  MainTabViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/8.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "MainTabViewController.h"
#import "PostsViewController.h"
#import "SettingsViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    PostsViewController *postsVC = PostsViewController.new;
    UINavigationController *postsNVC = [[UINavigationController alloc] initWithRootViewController:postsVC];
    SettingsViewController *settingVC = SettingsViewController.new;
    UINavigationController *settingNVC = [[UINavigationController alloc] initWithRootViewController:settingVC];
    UITabBarItem *postsItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"news"] tag:0];
    UITabBarItem *settingItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"setting"] tag:1];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
    postsNVC.tabBarItem = postsItem;
    settingNVC.tabBarItem = settingItem;
    
    self.viewControllers = @[postsNVC, settingNVC];
}

@end
