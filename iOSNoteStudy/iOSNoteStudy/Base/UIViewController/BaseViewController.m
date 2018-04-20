//
//  BaseViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/15.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mainBackgroundColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
    
    //修改tabBar的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = kScreenHeight - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

//返回
- (void)popViewControllerIndex:(NSInteger)index {
    NSInteger indexCount = [[self.navigationController viewControllers]indexOfObject:self];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:indexCount - MIN(indexCount, indexCount)] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
