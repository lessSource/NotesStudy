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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    //执行方法(没有方法)
    SEL selector = NSSelectorFromString(@"LSViewOverloadingData");
    if ([self respondsToSelector:selector]) {
        ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    }
    
    
    //selector 接收参数，或者有返回值
//    SEL selector1 = NSSelectorFromString(@"LSViewOverloadingData:ofView");
//    IMP imp = [self methodForSelector:selector1];
//    void (*func)(id, SEL, NSString *, NSString *) = (void *)imp;
////    self ? func(self, selector1, @"120", @"456") : @"890";
//
//    func(self, selector1, @"120", @"456");
    
//    CGRect someRect = CGRectMake(0, 0, 100, 100);
//    UIView *someView = [[UIView alloc]initWithFrame:someRect];
    
    SEL selector1 = NSSelectorFromString(@"LSViewOverloadingData:ofView:");
    if ([self respondsToSelector:selector1]) {
        IMP imp = [self methodForSelector:selector1];
        NSString * (*func)(id, SEL, NSString*, NSString*) = (void *)imp;
        NSString *result = self ?
        func(self, selector1, @"1234", @"133244") : @"2222";
        NSLog(@"%@",result);
    }
    
//    NSLog(@"-----%f",result.size.height);
//    NSLog(@"-----%f",result.size.width);
//    NSLog(@"------%@",result);
    
    
    
    
//    //全局设置
//    //设置导航栏背景颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor randomColor]];
//    //设置导航栏背景图片
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
//    //设置导航栏标题样式
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor purpleColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:12], NSFontAttributeName, nil]];
//    //设置导航栏返回按钮的颜色
//    [[UINavigationBar appearance] setTintColor:[UIColor randomColor]];
//    //设置导航栏隐藏
//    [[UINavigationBar appearance] setHidden:YES];
//    //局部设置 进入页面时修改，离开页面时还原
////    self.navigationController.navigationBar
//
    
}

- (void)LSViewOverloadingData {
    NSLog(@"12389120381290312");
}

- (CGRect)processRegion:(CGRect)someRect ofView:(UIView *)someView {
    NSLog(@"dddd");
    return CGRectZero;
}

//- (void)vi

//- (NSString *)LSViewOverloadingData:(NSString *)data ofView:(NSString *)view {
//    NSLog(@"dddd");
//    return @"112312";
//}

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
