//
//  SettingsViewController.m
//  KanZhiHu
//
//  Created by 朱安智 on 16/8/4.
//  Copyright © 2016年 朱安智. All rights reserved.
//

#import "SettingsViewController.h"

#import <Masonry.h>
#import <SDImageCache.h>
#import <MBProgressHUD.h>

@interface SettingsViewController ()

@property (strong, nonatomic) UILabel *lbSize;
@property (strong, nonatomic) UIButton *btnClear;

@property (strong, nonatomic) UILabel *lbJump;
@property (strong, nonatomic) UISwitch *switchJump;

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%s", __func__);
    self.title = @"Setting";
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.lbSize.text = [self stringFromSize:[[SDImageCache sharedImageCache] getSize]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews {
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.lbSize = UILabel.new;
    self.lbSize.textAlignment = NSTextAlignmentCenter;
    self.lbSize.text = [self stringFromSize:[[SDImageCache sharedImageCache] getSize]];
    self.btnClear = UIButton.new;
    [self.btnClear setTitle:@"Clear" forState:UIControlStateNormal];
    [self.btnClear addTarget:self action:@selector(clearButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.lbJump = UILabel.new;
    self.lbJump.textAlignment = NSTextAlignmentCenter;
    self.lbJump.text = @"Jump to ZhiHu";
    self.switchJump = UISwitch.new;
    self.switchJump.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"jumpToZhiHu"];
    [self.switchJump addTarget:self action:@selector(switchButtonChanged:) forControlEvents:UIControlEventValueChanged];
    self.cancelButton = UIButton.new;
    [self.cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.view addSubview:self.lbSize];
    [self.view addSubview:self.btnClear];
    [self.view addSubview:self.lbJump];
    [self.view addSubview:self.switchJump];
//    [self.view addSubview:self.cancelButton];
    
    [self.lbSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).with.offset(-40);
        make.left.equalTo(self.view).with.offset(20);
        make.width.equalTo(self.btnClear);
    }];
    [self.btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbSize);
        make.left.equalTo(self.lbSize.mas_right).with.offset(5);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.equalTo(self.lbSize);
    }];
    [self.lbJump mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).with.offset(40);
        make.left.equalTo(self.view).with.offset(20);
        make.width.equalTo(self.lbSize);
    }];
    [self.switchJump mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.btnClear);
        make.centerY.equalTo(self.lbJump);
    }];
//    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.lbJump).with.offset(80);
//        make.centerX.equalTo(self.view);
//        make.left.equalTo(self.lbSize);
//        make.right.equalTo(self.btnClear);
//        make.height.mas_equalTo(40);
//    }];
}

- (void)clearButtonClicked:(UIButton *)button {
    [self.hud showAnimated:YES whileExecutingBlock:^{
        [[SDImageCache sharedImageCache] clearDisk];
    } completionBlock:^{
        self.lbSize.text = [self stringFromSize:[[SDImageCache sharedImageCache] getSize]];
    }];
}

- (void)switchButtonChanged:(UISwitch *)switchButton {
    [[NSUserDefaults standardUserDefaults] setBool:switchButton.isOn forKey:@"jumpToZhiHu"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cancelButtonClicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)stringFromSize:(NSUInteger)size {
    NSInteger count = 0;
    CGFloat fsize = (CGFloat)size;
    while (fsize > 1024.0) {
        fsize /= 1024;
        count++;
    }
    NSArray *units = @[@"B", @"KB", @"MB", @"GB", @"TB", @"PB"];
    if (count < units.count) {
        return [NSString stringWithFormat:@"%.2f%@", fsize, units[count]];
    } else {
        return @"Error";
    }
}

@end
