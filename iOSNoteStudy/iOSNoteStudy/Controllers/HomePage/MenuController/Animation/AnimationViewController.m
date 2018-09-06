//
//  AnimationViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/17.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "AnimationViewController.h"
#import "AccordingLayerViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"动画";
}

- (NSArray *)buttonListArray {
    return @[@"显示层动画",@"关键帧动画",@"逐帧动画",@"Gif动画",@"CALayer层动画合集",@"测试",@"CAKeyFrameVC",@"动画效果",@"粒子动画",@"光波扫描动画",@"图表",@"图层复制",@"3D动画",@"CoverFlow",@"转场动画",@"视图转场",@"侧滑动画"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        AccordingLayerViewController *accordingLayerVC = [[AccordingLayerViewController alloc]init];
        [self pushViewController:accordingLayerVC animated:YES];
    }
}



@end
