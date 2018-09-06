//
//  ddddddViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/28.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ddddddViewController.h"
#import "MineViewController.h"
#import "MessageViewController.h"
#import "GitHubViewController.h"

@interface ddddddViewController ()

@end

@implementation ddddddViewController

- (instancetype)init {
    if (self = [super init]) {
        [self setUpUI];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpUI {
    [self setViewControllers:@[[MessageViewController new],[MineViewController new]] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
