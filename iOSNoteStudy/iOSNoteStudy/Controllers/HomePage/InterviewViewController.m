//
//  InterviewViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/8/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "InterviewViewController.h"
#import "ProblemWebViewController.h"

@interface InterviewViewController ()
@property (nonatomic, strong) NSArray *array;

@end

@implementation InterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array = @[@"APP启动过程",@"@property",@"SDWebImage",@"KVC&KVO"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)buttonListArray {
    return @[@"APP启动过程",@"Property",@"SDWebImage",@"KVC&KVO"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemWebViewController *problemWebVC = [[ProblemWebViewController alloc]init];
    problemWebVC.urlPath = self.array[indexPath.row];
    [self pushViewController:problemWebVC animated:YES];
    
}

@end
