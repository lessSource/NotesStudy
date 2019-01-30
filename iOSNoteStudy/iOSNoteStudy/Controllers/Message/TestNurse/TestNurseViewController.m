//
//  TestNurseViewController.m
//  iOSNoteStudy
//
//  Created by less on 2019/1/17.
//  Copyright © 2019 lj. All rights reserved.
//

#import "TestNurseViewController.h"
#import "NurseServiceViewController.h"
#import "NurseCommentsViewController.h"
#import "NurseCertificationViewController.h"
#import "XDPagesView.h"
#import "NurseHeaderView.h"
#import "NurseNavbarView.h"

static CGFloat const HeaderHeight = 300;

@interface TestNurseViewController () <XDPagesViewDataSourceDelegate, NurseNavbarViewDelegate>
@property (nonatomic, strong) NSMutableArray *currentItems;
@property (nonatomic, strong) XDPagesView *pagesView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NurseNavbarView *navBarView;

@end

@implementation TestNurseViewController

- (NurseNavbarView *)navBarView {
    if (_navBarView == nil) {
        _navBarView = [[NurseNavbarView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavbarAndStatusBar)];
        _navBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.0];
        _navBarView.delegate = self;
    }
    return _navBarView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试";
    self.titles = @[@"服务项目",@"用户评价",@"资格认证"];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor randomColor];
    
    XDTitleBarLayout *layout = [[XDTitleBarLayout alloc]init];
    layout.barMarginTop = kNavbarAndStatusBar;
    layout.barItemSize = CGSizeMake(kScreenWidth/3, 60);
    layout.barTextFont = [UIFont systemFontOfSize:12];
    layout.barTextColor = [UIColor colorWithHexString:@"#999999" alpha:1.0];
    
    self.pagesView = [[XDPagesView alloc]initWithFrame:self.view.bounds dataSourceDelegate:self beginPage:0 titleBarLayout:layout style:XDPagesViewStyleTablesFirst];
    
    NurseHeaderView *headerView = [[NurseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HeaderHeight)];
    _pagesView.headerView = headerView;
    //可以通过滑动表头滑动列表
    _pagesView.needSlideByHeader = YES;
    [self.view addSubview:self.pagesView];
    
    [self.view addSubview:self.navBarView];
    
}

#pragma mark - XDPagesViewDataSourceDelegate
- (NSArray<NSString *> *)xd_pagesViewPageTitles {
    return self.titles;
}

- (NSArray<NSString *> *)xd_pagesViewPageicons {
    return @[@"硬件",@"硬件",@"硬件"];
}

- (UIViewController *)xd_pagesViewChildControllerToPagesView:(XDPagesView *)pagesView forIndex:(NSInteger)index {
    UIViewController *pageVC = [pagesView dequeueReusablePageForIndex:index];
    if (!pageVC) {
        if (index == 0) {
            pageVC = [[NurseServiceViewController alloc]init];
        }else if (index == 1) {
            pageVC = [[NurseCommentsViewController alloc]init];
        }else {
            pageVC = [[NurseCertificationViewController alloc]init];
        }
    }
    return pageVC;
}

- (void)xd_pagesViewVerticalScrollOffsetyChanged:(CGFloat)changedy {
    if (changedy < 0) {
        CGFloat alpha = fabs(changedy/(HeaderHeight - kNavbarAndStatusBar));
        self.navBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    }
}

- (void)nurseNavbarSelect:(NSInteger)row {
    if (row == 0) {
        [self.navigationController popViewControllerAnimated:true];
    }
}


@end
