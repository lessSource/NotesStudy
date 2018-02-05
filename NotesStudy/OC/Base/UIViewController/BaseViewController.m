//
//  BaseViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/1/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.topItem.title = @"";
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = MAIN_COLOR;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)dealloc {
    NSLog(@"%@-------dealloc",NSStringFromClass([self class]));
}

@end


