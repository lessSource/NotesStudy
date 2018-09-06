//
//  PopUpViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PopUpViewController.h"
#import "LSWebViewController.h"

@interface PopUpViewController ()

@end

@implementation PopUpViewController


- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *nameButton = [[UIButton alloc]init];
    [nameButton setTitle:@"测试" forState:UIControlStateNormal];
    [nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nameButton.backgroundColor = [UIColor mainColor];
    nameButton.clipsToBounds = YES;
    nameButton.layer.cornerRadius = 5;
    [nameButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nameButton];
    [nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.offset(45);
        make.width.offset(120);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event
- (void)buttonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}


@end
