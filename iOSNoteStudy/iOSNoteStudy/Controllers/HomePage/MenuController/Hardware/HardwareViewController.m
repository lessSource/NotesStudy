//
//  HardwareViewController.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/6.
//  Copyright © 2018 lj. All rights reserved.
//

#import "HardwareViewController.h"
#import <GPUImage/GPUImage.h>


@interface HardwareViewController ()

@end

@implementation HardwareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSArray *)buttonListArray {    
    return @[@"相机",@"相册",@"通知",@"网络",@"麦克风",@"定位",@"通讯录",@"日历",@"备忘录",@"陀螺仪",@"重力感应"];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"123456");
    
     
    
}


@end
