//
//  NurseCommentsViewController.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//  用户评论

#import "NurseCommentsViewController.h"
#import "NurseCommentsHeaderView.h"
#import "NurseCommentsTableViewCell.h"

@interface NurseCommentsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NurseCommentsHeaderView *headerView;

@end

@implementation NurseCommentsViewController

- (NurseCommentsHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[NurseCommentsHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
        _headerView.backgroundColor = [UIColor colorWithHexString:@"#bbbbbb" alpha:0.1];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NurseCommentsTableViewCell class] forCellReuseIdentifier:@"NurseCommentsTableViewCell"];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NurseCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NurseCommentsTableViewCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}


@end
