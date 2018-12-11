//
//  MoreHomeViewController.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/11.
//  Copyright © 2018 lj. All rights reserved.
//

#import "MoreHomeViewController.h"
#import "MoreMineViewController.h"

@interface MoreHomeViewController ()

@end

@implementation MoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MoreMineViewController *moreMineVC = [[MoreMineViewController alloc]init];
    [self.navigationController pushViewController:moreMineVC animated:YES];
}


@end
