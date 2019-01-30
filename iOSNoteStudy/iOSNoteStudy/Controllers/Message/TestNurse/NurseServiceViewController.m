//
//  NurseServiceViewController.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//  服务项目

#import "NurseServiceViewController.h"
#import "NurseServiceTableViewCell.h"

@interface NurseServiceViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NurseServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor randomColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55 + kBarHeight, 0);
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NurseServiceTableViewCell class] forCellReuseIdentifier:@"NurseServiceTableViewCell"];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 55 - kBarHeight, kScreenWidth, 55 + kBarHeight)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton *consultingButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 55)];
    [consultingButton setTitle:@"在线咨询" forState:UIControlStateNormal];
    [consultingButton setTitleColor:[UIColor colorWithHexString:@"#f08519" alpha:1.0] forState:UIControlStateNormal];
    consultingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:consultingButton];
    
    UIButton *appointmentButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 55)];
    [appointmentButton setTitle:@"立即预约" forState:UIControlStateNormal];
    [appointmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    appointmentButton.backgroundColor = [UIColor colorWithHexString:@"#f08519" alpha:1.0];
    appointmentButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:appointmentButton];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NurseServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NurseServiceTableViewCell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


@end
