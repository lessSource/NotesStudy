//
//  OptionsViewController.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/6.
//  Copyright © 2018 lj. All rights reserved.
//

#import "OptionsViewController.h"
#import "OptionsView.h"

@interface OptionsViewController () <OptionsViewDelegate>

@end

@implementation OptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"按钮选择";
    [self initView];
}


#pragma mark - initView
- (void)initView {
    OptionsView *optionsView = [[OptionsView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 100)];
    optionsView.delegate = self;
    [self.view addSubview:optionsView];
}


- (NSArray *)optionsViewData:(OptionsView *)optionsView {
    return @[@"按钮1",@"按钮2",@"按钮3",@"按钮4",@"按钮5",@"按钮6",@"按钮7",@"按钮8"];
}

- (void)optionsView:(OptionsView *)optionsView didSelect:(NSArray *)buttonArray {
    NSLog(@"%@",buttonArray);
}

- (void)optionsView:(OptionsView *)optionsView didSelect:(NSString *)buttonStr selectRow:(NSInteger)row {
    NSLog(@"%@-----",buttonStr);
}

@end
