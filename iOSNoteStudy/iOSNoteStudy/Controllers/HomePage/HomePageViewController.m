//
//  HomePageViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//


#import "HomePageViewController.h"
#import "LSWebViewController.h"
#import "BannerCycleView.h"
#import "BannerViewCell.h"
#import "HomePageMenuView.h"
#import "MallViewController.h" //
#import "CardCollectionView.h" //
#import "CircleFriendsViewController.h" //
#import "AnimationViewController.h"
#import "ThreadViewController.h"
#import "InterviewViewController.h"
#import "HardwareViewController.h"
#import "MoreViewController.h"

#import <ZipArchive/ZipArchive.h>

API_AVAILABLE(ios(10.0))
@interface HomePageViewController () <BannerCycleViewDataSource,HomePageMenuDelegate,HomePageMenuDataSource,CardCollectionDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) BannerCycleView *cycleView;
@property (nonatomic, strong) NSArray *cycleArray;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) HomePageMenuView *homePageMenu;
@property (nonatomic, strong) CardCollectionView *cardView;

@property (nonatomic, strong) UIView *testView;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    [self loadData];
    [self initView];
    [self viewLayout];
}

#pragma mark - loadData
- (void)loadData {
    self.cycleArray = @[[NSString stringWithFormat:@"%@9b4b7dad44c5823d577788c8923d7b0c.jpg",PicturePath],[NSString stringWithFormat:@"%@285fab46eed8db8d188f59592d486961.jpg",PicturePath],[NSString stringWithFormat:@"%@2352dfd38bc6da3f765d2b71868ee562.jpg",PicturePath]];
    self.menuArray = @[@"商城",@"朋友圈",@"动画",@"数据",@"图表",@"网络",@"线程",@"硬件"];
}

#pragma mark - initView
- (void)initView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar - kBottomBarHeight)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.backgroundColor = [UIColor mainBackgroundColor];
    [self.view addSubview:self.scrollView];
    
    self.cycleView = [[BannerCycleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth *2/5)];
    self.cycleView.dataSource = self;
    [self.cycleView registerClass:[BannerViewCell class] forCellReuseIdentifier:NSStringFromClass([BannerViewCell class])];
    [self.contentView addSubview:self.cycleView];
    
    self.homePageMenu = [[HomePageMenuView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cycleView.frame) + 10, kScreenWidth - 20, 180)];
    self.homePageMenu.menuDataSource = self;
    self.homePageMenu.menuDelegate = self;
    self.homePageMenu.menuColor = [UIColor blackColor];
    [self.contentView addSubview:self.homePageMenu];
    
    self.cardView = [[CardCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.homePageMenu.frame) + 10, kScreenWidth, HomeActivityHeight)];
    self.cardView.delegate = self;
    [self.contentView addSubview:self.cardView];
}

- (void)viewLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cardView.mas_bottom).offset(10);
    }];
}

#pragma mark - BannerCycleViewDataSource
- (NSInteger)numberOfRowsInCycleView:(BannerCycleView *)cycleView {
    return self.cycleArray.count;
}

- (UICollectionViewCell *)cycleView:(BannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row {
    BannerViewCell *cell = (BannerViewCell *)[cycleView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BannerViewCell class]) forRow:row];
    cell.image.image = [UIImage imageNamed:self.cycleArray[row]];
    return cell;
}

#pragma mark - HomePageMenuDataSource
- (NSArray *)homePageMenuName:(HomePageMenuView *)menuView {
    return self.menuArray;
}

- (NSArray *)homePageMenuImage:(HomePageMenuView *)menuView {
    return self.menuArray;
}

- (NSArray *)homePageMenuNumber:(HomePageMenuView *)menuView {
    return @[@"0",@"3",@"33",@"333",@"333",@"33",@"3",@"0"];
}

- (void)menuView:(HomePageMenuView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        MallViewController *mallVC = [[MallViewController alloc]init];
        [self pushViewController:mallVC animated:YES];
    }else if (indexPath.item == 1) {
        CircleFriendsViewController *circleFriendsVC = [[CircleFriendsViewController alloc]init];
        [self pushViewController:circleFriendsVC animated:YES];
    }else if (indexPath.item == 2) {
        AnimationViewController *animationVC = [[AnimationViewController alloc]init];
        [self pushViewController:animationVC animated:YES];
    }else if (indexPath.item == 3) {
    }else if (indexPath.item == 4) {
    }else if (indexPath.item == 5) {
    }else if (indexPath.item == 6) {
        ThreadViewController *threadVC = [[ThreadViewController alloc]init];
        [self pushViewController:threadVC animated:YES];
    }else if (indexPath.item == 7) {
        HardwareViewController *hardwareVC = [[HardwareViewController alloc]init];
        [self pushViewController:hardwareVC animated:YES];
    }
}

#pragma mark - CardCollectionDelegate
- (void)cardCollectionView:(CardCollectionView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *classNameArray = @[@"OptionsViewController",@"HorizontalMenuViewController",@"PopUpViewController",@"",@"",@"",@"",@"",@"MoreViewController"];
    Class classVC = NSClassFromString(classNameArray[indexPath.item]);
    [self pushViewController:[classVC new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    LSWebViewController *webVC = [[LSWebViewController alloc]init];
//    [self pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor mainBackgroundColor];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}


@end
