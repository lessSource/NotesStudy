//
//  AccordingLayerViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/17.
//  Copyright © 2018年 lj. All rights reserved.
//  显示层动画

#import "AccordingLayerViewController.h"

@interface AccordingLayerViewController ()
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) NSInteger index;

@end

@implementation AccordingLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"显示层动画";
    
    self.loginButton = [[UIButton alloc]init];
    self.loginButton.layer.cornerRadius = 25;
    self.loginButton.clipsToBounds = YES;
    self.loginButton.backgroundColor = [UIColor mainColor];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.height.offset(50);
    }];
}

- (void)loginButtonClick:(UIButton *)sender {
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.index * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.loginButton.transform = endAngle;
    } completion:^(BOOL finished) {
        self.index += 2;
        [self loginButtonClick:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
