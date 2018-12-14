//
//  SelectMediaViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/12/12.
//  Copyright © 2018 lj. All rights reserved.
//

#import "SelectMediaViewController.h"
#import "SelectMediaView.h"

@interface SelectMediaViewController () <SelectMediaViewDelegate>
@property (nonatomic, strong) SelectMediaView *mediaView;

@end

@implementation SelectMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片展示";
    [self initView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - initView
- (void)initView {
    self.mediaView = [[SelectMediaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.mediaView.delegate = self;
    self.mediaView.isImplement = YES;
    self.mediaView.isAdapter = YES;
    self.mediaView.maxImageCount = 15;
    [self.view addSubview:self.mediaView];
    
}

#pragma mark - SelectMediaViewDelegate
- (NSArray *)dataArrayNumberOfItems:(SelectMediaView *)mediaView {
    return @[@"picture",@"picture",@"picture",@"picture",@"http://pic.qiantucdn.com/58pic/25/99/58/58aa038a167e4_1024.jpg",@"picture",@"picture",@"picture",@"picture",@"picture"];
}


- (void)selectDeleteMediaView:(SelectMediaView *)mediaView deleteItem:(NSInteger)item {
    NSLog(@"------删除%ld--------",item);
}

- (void)selectAddMediaView:(SelectMediaView *)mediaView {
    NSLog(@"-------添加-------");
}

- (void)selectVideoMediaView:(SelectMediaView *)mediaView videoItem:(NSInteger)item {
    NSLog(@"------视频%ld--------",item);
}

- (void)selectImageMediaView:(SelectMediaView *)mediaView imageItem:(NSInteger)item {
    NSLog(@"------图片%ld--------",item);
}



#pragma mark - Lazy
- (void)rightItemClick {
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.navigationItem.rightBarButtonItem.title = @"完成";
        self.mediaView.isDisplayDelete = YES;
        self.mediaView.isImplement = NO;
    }else {
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.mediaView.isDisplayDelete = NO;
        self.mediaView.isImplement = YES;
    }
    [self.mediaView reloadDataSelectMediaView];
}



@end
