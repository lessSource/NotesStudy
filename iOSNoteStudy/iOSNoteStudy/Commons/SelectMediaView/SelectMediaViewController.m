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

@end

@implementation SelectMediaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片展示";
    [self initView];
}

#pragma mark - initView
- (void)initView {
    SelectMediaView *mediaView = [[SelectMediaView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    mediaView.delegate = self;
    [self.view addSubview:mediaView];
}

#pragma mark - SelectMediaViewDelegate
- (NSArray *)dataArrayNumberOfItems:(SelectMediaView *)mediaView {
    return @[@"icon_noData",@"icon_noData",@"icon_noData"];
}

@end
