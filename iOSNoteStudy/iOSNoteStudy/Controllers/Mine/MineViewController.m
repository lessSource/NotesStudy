//
//  MineViewController.m
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    NSMutableArray *arrItem = [NSMutableArray array];
    
    UIPreviewAction *cancelAction = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"didClickCancel");
    }];
    
    UIPreviewAction *previewAction = [UIPreviewAction actionWithTitle:@"替换该元素" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
       
    }];
    
    UIPreviewActionGroup *actionGroup = [UIPreviewActionGroup actionGroupWithTitle:@"选项组" style:UIPreviewActionStyleDefault actions:@[cancelAction, previewAction]];
    
    [arrItem addObjectsFromArray:@[cancelAction, previewAction, actionGroup]];
    
    return arrItem;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
