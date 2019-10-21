//
//  PopUpViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/21.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "PopUpViewController.h"
#import "PopUpView.h"

@interface PopUpViewController ()
@property (nonatomic, strong) PopUpView *popUpView;
@property (nonatomic, strong) PopUpView *popUpView1;


@end

@implementation PopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popUpView.block = ^{
        NSLog(@"ddddddd");
        self.popUpView1.size = CGSizeMake(kScreenWidth - 100, 250);
        self.popUpView1.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView1 direction:PopUpViewDirectionTypeCenter];
    };
    
}

- (NSArray *)buttonListArray {
    return @[@"上",@"下",@"左",@"右",@"中"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.popUpView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView direction:PopUpViewDirectionTypeUp];
    }else if (indexPath.row == 1) {
        self.popUpView.frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView direction:PopUpViewDirectionTypeDown];
    }else if (indexPath.row == 2) {
        self.popUpView.frame = CGRectMake(0, 0, kScreenWidth - 100, kScreenHeight);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView direction:PopUpViewDirectionTypeLeft];
    }else if (indexPath.row == 3) {
        self.popUpView.frame = CGRectMake(100, 0, kScreenWidth - 100, kScreenHeight);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView direction:PopUpViewDirectionTypeRight];
    }else if (indexPath.row == 4) {
        self.popUpView.size = CGSizeMake(kScreenWidth - 100, 250);
        self.popUpView.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
        [[PopUpViewObjeect sharrPopUpView] presentContentView:self.popUpView direction:PopUpViewDirectionTypeCenter];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy
- (PopUpView *)popUpView {
    if (_popUpView == nil) {
        _popUpView = [[PopUpView alloc]init];
        _popUpView.backgroundColor = [UIColor whiteColor];
    }
    return _popUpView;
}

- (PopUpView *)popUpView1 {
    if (_popUpView1 == nil) {
        _popUpView1 = [[PopUpView alloc]init];
        _popUpView1.backgroundColor = [UIColor whiteColor];
    }
    return _popUpView1;
}


@end
