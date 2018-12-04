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
#import "MallViewController.h"
#import "CardCollectionView.h"
#import "CircleFriendsViewController.h"
#import "AnimationViewController.h"
#import "PopUpViewController.h"
#import "ThreadViewController.h"
#import "ArticlePublishedViewController.h"
#import "PublicPersonalViewController.h"
#import "ContactDataObject.h"
#import "InterviewViewController.h"

#import "ddddddViewController.h"

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

#pragma mark - Lazy
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor mainBackgroundColor];
        [self.scrollView addSubview:_contentView];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    
    self.cycleArray = @[[NSString stringWithFormat:@"%@9b4b7dad44c5823d577788c8923d7b0c.jpg",PicturePath],[NSString stringWithFormat:@"%@285fab46eed8db8d188f59592d486961.jpg",PicturePath],[NSString stringWithFormat:@"%@2352dfd38bc6da3f765d2b71868ee562.jpg",PicturePath]];
    self.menuArray = @[@"商城",@"朋友圈",@"动画",@"数据",@"图表",@"网络",@"线程",@"硬件"];
    
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
    
    self.testView = [[UIView alloc]init];
    self.testView.backgroundColor = [UIColor mainColor];
    [self.contentView addSubview:self.testView];
    
    [self viewLayout];
    
//    for (int j = 0; j < 500; j ++) {
//        int number = random()%100;
//        NSMutableArray *array = [NSMutableArray array];
//        for (int i = 0 ; i < number; i ++) {
//            int num = random()%500;
//            [array addObject:@(num)];
//        }
//        NSArray *sortintArr = [LSSettingUtil sortingWithArray:array methodType:SortingMethodBubblingType sortingType:SortingAscendingType];
//        NSString *str = [sortintArr componentsJoinedByString:@","];
//        [LSSettingUtil writeFileData:str];
//    }


//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSFileManager *file = [NSFileManager defaultManager];
//        NSError *error;
//        NSArray *nameArray = [file contentsOfDirectoryAtPath:JSONPath error:&error];
//        NSMutableArray *dataArray = [NSMutableArray array];
//        for (NSString *path in nameArray) {
//            NSData *data = [file contentsAtPath:[NSString stringWithFormat:@"%@%@",JSONPath,path]];
////            NSString *dataStr  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//            for (NSDictionary *dic in array) {
//                if (dic.allKeys.count == 2) {
//                    break;
//                }
//                @autoreleasepool {
//                    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//                    [dataDic setObject:dic[@"title"] forKey:@"title"];
//                    [dataDic setObject:dic[@"author"] forKey:@"author"];
//                    if ([path hasPrefix:@"poet.song"]) {
//                        [dataDic setObject:@"宋" forKey:@"dynasty"];
//                    }else {
//                        [dataDic setObject:@"唐" forKey:@"dynasty"];
//                    }
//                    NSArray *strainsArr = (NSArray *)dic[@"strains"];
//                    [dataDic setObject:[strainsArr componentsJoinedByString:@""] forKey:@"strains"];
//                    NSArray *paragraphsArr = (NSArray *)dic[@"paragraphs"];
//                    [dataDic setObject:[paragraphsArr componentsJoinedByString:@""] forKey:@"paragraphs"];
//                    [[ContactDataObject shareInstance] insertPoetryData:dataDic];
//                }
//            }
//
//            [dataArray addObject:array];
//        }
//    });
//

    

}

- (void)viewLayout {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardView.mas_bottom).offset(10);
        make.width.offset(kScreenWidth);
        make.height.offset(200);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.testView.mas_bottom).offset(10);
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
    NSLog(@"------%ld------",indexPath.item);
    if (indexPath.item == 0) {
        MallViewController *mallVC = [[MallViewController alloc]init];
        [self pushViewController:mallVC animated:YES];
        [[UIImage convertGradientToImage:self.view] loadImageSave:^(BOOL saveSuccess, BOOL createSuccess) {
            NSLog(@"");
        }];
    }else if (indexPath.item == 1) {
        CircleFriendsViewController *circleFriendsVC = [[CircleFriendsViewController alloc]init];
        [self pushViewController:circleFriendsVC animated:YES];
    }else if (indexPath.item == 2) {
        AnimationViewController *animationVC = [[AnimationViewController alloc]init];
        [self pushViewController:animationVC animated:YES];
    }else if (indexPath.item == 3) {
        PopUpViewController *popUpVC = [[PopUpViewController alloc]init];
        [self presentViewController:popUpVC animated:NO completion:nil];
    }else if (indexPath.item == 4) {
//        BaseTabBarController *tabBarController = [[BaseTabBarController alloc] init];
        ddddddViewController *ddd = [[ddddddViewController alloc]init];
        [self pushViewController:ddd animated:YES];
        
//        tabBarController.hidesBottomBarWhenPushed = YES;
//        BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:tabBarController];
//        [nav setNavigationBarHidden:YES];
//        [self pushViewController:nav.visibleViewController animated:YES];
    }else if (indexPath.item == 5) {
        LSWebViewController *webVC = [[LSWebViewController alloc]init];
        [self pushViewController:webVC animated:YES];
    }else if (indexPath.item == 6) {
        ThreadViewController *threadVC = [[ThreadViewController alloc]init];
        [self pushViewController:threadVC animated:YES];
    }else if (indexPath.item == 7) {
//        ArticlePublishedViewController *articlePublishedVC = [[ArticlePublishedViewController alloc]init];
//        [self pushViewController:articlePublishedVC animated:YES];
        PublicPersonalViewController *publicPersonalVC = [[PublicPersonalViewController alloc]init];
        [self pushViewController:publicPersonalVC animated:YES];
    }
}

#pragma mark - CardCollectionDelegate
- (void)cardCollectionView:(CardCollectionView *)menuView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    InterviewViewController *interViewVC = [[InterviewViewController alloc]init];
    [self pushViewController:interViewVC animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LSWebViewController *webVC = [[LSWebViewController alloc]init];
    [self pushViewController:webVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
