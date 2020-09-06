//
//  InterviewViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/8/27.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "InterviewViewController.h"
#import "ProblemWebViewController.h"
#import "CustomNotificationCenter.h"

@interface InterviewViewController () <UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation InterviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavView];
    [self.dataArray addObjectsFromArray:@[@"UI相关", @"runtime", @"算法相关", @"内存管理", @"Block原理", @"多线程相关", @"RunLoop", @"网络相关", @"持久化", @"设计模式", @"关键字相关", @"生命周期",@"分类原理", @"三方原理",@"SDWebImage",@"NSURLSession",@"AFNetWorking",@"响应链",@"FMDB",@"定时器",@"iOS面试大全",@"CoreAnimation动画",@"Swift",@"面试（1~ 50）",@"面试题50以后"]];
    
}

#pragma mark - initNavView
- (void)initNavView {
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 6, kScreenWidth, 32)];
    textField.placeholder = @"请输入要搜索的词";
    textField.font = [UIFont systemFontOfSize:13];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.cornerRadius = 16;
    textField.clipsToBounds = true;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    [textField setUserInteractionEnabled:true];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 42, 32)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(12, 7, 18, 18)];
    image.image = [UIImage imageNamed:@"icon_Shape"];
    [view addSubview:image];
    textField.leftView = view;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = textField;
    self.navigationItem.hidesBackButton = true;
}

- (NSArray *)buttonListArray {
    return self.dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProblemWebViewController *problemWebVC = [[ProblemWebViewController alloc]init];
    if ([self.dataArray[indexPath.row] isEqualToString:@"AFNetWorking"]) {
        problemWebVC.urlPath = @"https://segmentfault.com/a/1190000020383827?utm_source=tag-newest";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"算法相关"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/2496f7be35d3";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"响应链"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/2e074db792ba";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"FMDB"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/dfc4fd6e666d";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"定时器"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/c167ca4d1e7e";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"iOS面试大全"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/e709fde38de3";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"CoreAnimation动画"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/7018e61b6ee5";
    }else if ([self.dataArray[indexPath.row] isEqualToString:@"Swift"]) {
        problemWebVC.urlPath = @"https://www.jianshu.com/p/744e5c3af37e";
    }else {
        problemWebVC.urlPath = self.dataArray[indexPath.row];
    }
    [self pushViewController:problemWebVC animated:true];
}

#pragma mark - click
- (void)rightItemClick {
    [self.navigationController popViewControllerAnimated:true];
}


#pragma mark - Lazy
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
