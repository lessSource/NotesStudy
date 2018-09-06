//
//  MallViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/7.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "MallViewController.h"
#import "ShoppingCartViewController.h"
#import "GoodsDetailsViewController.h"

@interface MallViewController ()

@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商城";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)buttonListArray {
    return @[@"购物车",@"商品详情"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShoppingCartViewController *shoppingCartVC = [[ShoppingCartViewController alloc]init];
        [self pushViewController:shoppingCartVC animated:YES];
    }else if (indexPath.row == 1) {
        GoodsDetailsViewController *goodsDetailVC = [[GoodsDetailsViewController alloc]init];
        [self pushViewController:goodsDetailVC animated:YES];
    }
}


@end
