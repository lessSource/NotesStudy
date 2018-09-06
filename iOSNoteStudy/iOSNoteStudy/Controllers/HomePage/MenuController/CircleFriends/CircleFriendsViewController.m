//
//  CircleFriendsViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "CircleFriendsViewController.h"
#import "CircleFriendsTableViewCell.h"
#import "BaseTableView.h"

static NSString *const circleFriendsCell = @"CircleFriendsCell";

@interface CircleFriendsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation CircleFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"朋友圈";
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar - kBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CircleFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:circleFriendsCell];
    if (cell == nil) {
        cell = [[CircleFriendsTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:circleFriendsCell];
    }
    cell.textLabel.text = @"测试";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end

