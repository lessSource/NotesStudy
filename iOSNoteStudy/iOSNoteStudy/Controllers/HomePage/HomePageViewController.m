//
//  HomePageViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//


#import "HomePageViewController.h"
#import "MineViewController.h"
#import "NotificationCategory.h"

@interface HomePageViewController () <UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation HomePageViewController

#pragma mark - Lazy
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    //注册3D Touch
    /**
     *   从iOS9开始，可以通过这个类来判断运行程序对应的设备是否支持3D Touch功能
     *   UIForceTouchCapabilityUnknown = 0,       未知
     *   UIForceTouchCapabilityUnavailable = 0,   不可用
     *   UIForceTouchCapabilityAvailable = 0,     可用
     */
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:self.scrollView];
            }
        }
    }
    
}

- (void)viewLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo()
    }];
}

#pragma mark - UIViewControllerPreviewingDelegate
//点击进入预览模式
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    MineViewController *mineVC = [[MineViewController alloc]init];
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 300);
    previewingContext.sourceRect = rect;
    return mineVC;
}

//继续按压进入
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
