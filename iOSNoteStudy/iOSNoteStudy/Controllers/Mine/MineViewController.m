//
//  MineViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#define headPortrait_Height kScreenWidth/5*4

#import "MineViewController.h"
#import "BaseTableView.h"
#import "AnimationViewController.h"
#import "MineHeaderView.h"
#import <objc/message.h>

@interface MineViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) MineHeaderView *mineHeaderView;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";

    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headPortrait_Height)];
    self.mineHeaderView = [[MineHeaderView alloc]initWithFrame:headerView.bounds];
    self.mineHeaderView.layer.contents = (__bridge id _Nullable)([UIImage convertGradientToImage:headerView].CGImage);
    [headerView addSubview:self.mineHeaderView];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kBottomBarHeight - kNavbarAndStatusBar) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifire = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifire];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollViewY = scrollView.contentOffset.y;
    if (scrollViewY < 0) {
        CGRect frame = self.mineHeaderView.frame;
        frame.origin.y = scrollViewY;
        frame.size.height = headPortrait_Height - scrollViewY;
        self.mineHeaderView.frame = frame;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnimationViewController *animationVC = [[AnimationViewController alloc]init];
    [self pushViewController:animationVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
