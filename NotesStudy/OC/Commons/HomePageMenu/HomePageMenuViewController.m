//
//  HomePageMenuViewController.m
//  NoteDome
//
//  Created by Lj on 2018/1/18.
//  Copyright © 2018年 Lj. All rights reserved.
//

#import "HomePageMenuViewController.h"
#import "HomePageMenuView.h"

@interface HomePageMenuViewController () <HomePageMenuDataSource,HomePageMenuDelegate>
@property (nonatomic, strong) HomePageMenuView *homePageMenu;
@property (nonatomic, strong) NSArray *dateArray;

@end

@implementation HomePageMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MAIN_COLOR;
    self.title = @"菜单";
    self.dateArray = @[@"菜单1",@"菜单2",@"菜单3",@"菜单4",@"菜单5",@"菜单6",@"菜单7"];
    
    self.homePageMenu = [[HomePageMenuView alloc]initWithFrame:CGRectMake(10, kNavbarAndStatusBar, kScreenWidth - 20, 50)];
    self.homePageMenu.menuDataSource = self;
    self.homePageMenu.menuDelegate = self;
    [self.view addSubview:self.homePageMenu];
    
    UIButton *nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"刷新" forState:UIControlStateNormal];
    [nameButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    nameButton.backgroundColor = [UIColor blueColor];
    nameButton.clipsToBounds = YES;
    nameButton.layer.cornerRadius = 5;
    [nameButton addTarget:self action:@selector(nameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nameButton];
    [nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(50);
        make.width.offset(100);
        make.top.equalTo(self.homePageMenu.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset((kScreenWidth - 100)/2);
    }];
}

#pragma mark - HomePageMenuDataSource
- (NSArray *)homePageMenuName:(HomePageMenuView *)menuView {
    return self.dateArray;
}

- (NSArray *)homePageMenuNumber:(HomePageMenuView *)menuView {
    return @[@"0",@"3",@"33",@"333",@"33",@"3",@"0"];
}

- (void)menuView:(HomePageMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"------%ld------",indexPath.item);
}

- (void)nameButtonClick:(UIButton *)sender {
     NSInteger count = arc4random()%20;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        [arr addObject:[NSString stringWithFormat:@"菜单%d",i]];
    }
    self.dateArray = [NSArray arrayWithArray:arr];
    [self.homePageMenu reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
