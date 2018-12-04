//
//  GitHubViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/9.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "GitHubViewController.h"
#import "BaseTableView.h"
#import "GitHubListModel.h"
#import "GitHubTableViewCell.h"
#import "LSWebViewController.h"

static NSString *const GitHubCell = @"GitHubCell";

@interface GitHubViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) BaseTableView *tabelView;
@property (nonatomic, strong) GitHubListModel *listModel;

@end

@implementation GitHubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopBarHeight)];
    [self.searchBar setTintColor:[UIColor mainColor]];
    [self.searchBar setPlaceholder:@"关键字"];
    UITextField * searchField = [self.searchBar valueForKey:@"_searchField"];
    [searchField setValue:LSFont_Size_12 forKeyPath:@"_placeholderLabel.font"];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    self.tabelView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar - kBottomBarHeight) style:UITableViewStylePlain];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.isRefresh = YES;
    self.tabelView.estimatedRowHeight = 44;
    self.tabelView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.tabelView];
    
    [self requestGetGitHubSearch:@"微信"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listModel.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GitHubTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GitHubCell];
    if (cell == nil) {
        cell = [[GitHubTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GitHubCell];
    }
    cell.item = self.listModel.items[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];
    GitHubListItemModel *itemModel = self.listModel.items[indexPath.row];
    LSWebViewController *webVC = [[LSWebViewController alloc]init];
    webVC.urlStr = itemModel.html_url;
    [self pushViewController:webVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"------%@",searchText);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self requestGetGitHubSearch:searchBar.text];
    [searchBar resignFirstResponder];
}

#pragma mark - request
- (void)requestGetGitHubSearch:(NSString *)searchStr {
    [[LSAlertUtil alertManager]showLoadinginView:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:searchStr forKey:@"q"];
    [params setObject:@"Objective-C" forKey:@"language"];
    [params setObject:@"Repositories" forKey:@"type"];
    [LSHTTPRequest requestGetGitHubSearch:^(id results, BOOL success) {
        if (success) {
            self.listModel = [GitHubListModel yy_modelWithJSON:results];
        }
        self.tabelView.placeholderShow(self.listModel.items.count <= 0);
        [self.tabelView reloadData];
        [[LSAlertUtil alertManager]hiddenLoading];
    } params:params];
}

@end
