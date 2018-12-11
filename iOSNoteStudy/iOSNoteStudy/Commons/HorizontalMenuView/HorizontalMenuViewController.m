//
//  HorizontalMenuViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/12/11.
//  Copyright © 2018 lj. All rights reserved.
//

#import "HorizontalMenuViewController.h"
#import "HorizontalMenuView.h"

@interface HorizontalMenuViewController () <HorizontalMenuDelegate>

@end

@implementation HorizontalMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜单栏";
    [self initView];
}

#pragma mark - initView
- (void)initView {
    HorizontalMenuView *menuView = [[HorizontalMenuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    menuView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    menuView.delegate = self;
    [self.view addSubview:menuView];
}

#pragma mark - HorizontalMenuDelegate
- (NSArray *)horizontalMenuArray:(UIView *)menuView {
    return @[@"菜单一",@"菜单二",@"菜单三",@"菜单四",@"菜单五",@"菜单六",@"菜单七菜单七菜单七菜单七菜单七菜单七菜单七菜单七菜单七菜单七"];
}

- (void)menuView:(UIView *)menuView didSelectButton:(NSInteger)buttonSerial sort:(MenuSoreType)sortType {
    NSLog(@"----%ld---%ld----",(long)buttonSerial,sortType);
}

//- (NSArray <NSArray *>*)horizontalMenuImageArray:(UIView *)menuView {
//    return @[@[@"1",@"2",@"3"],@[],@[],@[]];
//}

@end
