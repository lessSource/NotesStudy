//
//  PublicPersonalViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/7/25.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PublicPersonalViewController.h"
#import <VTMagic/VTMagicController.h>
#import "PersonalContentViewController.h"
#import "PersonalTableView.h"
#import "UIView+Layout.h"

@interface PublicPersonalViewController () <VTMagicViewDelegate,VTMagicViewDataSource>
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIScrollView *childScrollView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) NSMutableArray <PersonalTableView *> *tableViews;
@property (nonatomic, strong) NSMutableArray *gesturesArray;

@end

@implementation PublicPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人详情";
    
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.headerView];
    [self.mainScrollView addSubview:self.magicController.view];
    [self.magicController.magicView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VTMagicViewDelegate,VTMagicViewDataSource
- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:NSStringFromClass([UIButton class])];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor randomColor] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    return menuItem;
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    return @[@"栏目一",@"栏目二",@"栏目三",@"栏目四"];
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
    NSString *identifier = [NSString stringWithFormat:@"%@_%ld",NSStringFromClass([PublicPersonalViewController class]),pageIndex];
    
    PersonalContentViewController *personalContentVC = [magicView dequeueReusablePageWithIdentifier:identifier];
    if (!personalContentVC) {
        personalContentVC = [[PersonalContentViewController alloc]init];
    }
    personalContentVC.view.backgroundColor = [UIColor randomColor];
    return personalContentVC;
}

- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    PersonalContentViewController *personalContentVC = (PersonalContentViewController *)viewController;
    NSArray *gesturesArray = personalContentVC.tableView.gestureRecognizers;
    NSArray *array = self.gesturesArray[pageIndex];
    if (array.count == 0) {
        [self.gesturesArray replaceObjectAtIndex:pageIndex withObject:gesturesArray];
    }
    [personalContentVC.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self _removeGesturesToAddNewGestureRecognizers:self.gesturesArray[pageIndex]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (change[@"new"]) {
        CGPoint point = [(NSValue *)change[@"new"] CGPointValue];
        if (point.y <= 0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.headerView.origin = CGPointMake(0, 0);
            }];
        }else if (point.y >= 200) {
            [UIView animateWithDuration:0.25 animations:^{
                self.headerView.origin = CGPointMake(0, - 200);
            }];
        }else {
            self.headerView.origin = CGPointMake(0, - point.y);
        }
        self.magicController.magicView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.headerView.frame) - kNavbarAndStatusBar);
    }
}

#pragma mark - Private
//替换手势
- (void)_removeGesturesToAddNewGestureRecognizers:(NSArray *)gestureRecognizers {
    //移除主scrollView原有手势操作
    NSMutableArray *listArray = [NSMutableArray arrayWithArray:self.mainScrollView.gestureRecognizers];
    for (UIGestureRecognizer *gestureRecognizer in listArray) {
        [self.mainScrollView removeGestureRecognizer:gestureRecognizer];
    }
    //将需要的手势操作加到主scrollView中
    for (UIGestureRecognizer *gestureRecognizer in gestureRecognizers) {
        [self.mainScrollView addGestureRecognizer:gestureRecognizer];
    }
}

#pragma mark - Lazy
- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
        _headerView.backgroundColor = [UIColor randomColor];
    }
    return _headerView;
}

- (NSMutableArray *)gesturesArray {
    if (_gesturesArray == nil) {
        _gesturesArray = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            NSArray *arr = [NSArray array];
            [_gesturesArray addObject:arr];
        }
    }
    return _gesturesArray;
}

- (VTMagicController *)magicController {
    if (_magicController == nil) {
        _magicController = [[VTMagicController alloc]init];
        _magicController.magicView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(self.headerView.frame) - kNavbarAndStatusBar);
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.backgroundColor = [UIColor whiteColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.sliderColor = [UIColor mainColor];
        _magicController.magicView.navigationHeight = 45;
        _magicController.magicView.navigationInset = UIEdgeInsetsMake(0, 0, 2, 0);
        _magicController.magicView.delegate = self;
        _magicController.magicView.dataSource = self;
        [self addChildViewController:_magicController];
    }
    return _magicController;
}


@end
