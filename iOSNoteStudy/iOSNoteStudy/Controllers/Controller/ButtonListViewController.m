//
//  ButtonListViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/8.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ButtonListViewController.h"
#import "BaseTableView.h"
#import "ButtonTableViewCell.h"

static NSString *const buttonCell = @"ButtonCell";

@interface ButtonListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) BaseTableView *tabelView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ButtonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [self buttonListArray];
    
    self.tabelView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusHeight) style:UITableViewStyleGrouped];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.rowHeight = 60;
    self.tabelView.tableFooterView = [[UIView alloc]init];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];
}

- (NSArray *)buttonListArray {
    return @[];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buttonCell];
    if (cell == nil) {
        cell = [[ButtonTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:buttonCell];
    }
    cell.contentLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { }

@end
