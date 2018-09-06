//
//  GoodsDetailsViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/7.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "SelectMediaView.h"
#import "OptionsView.h"

@interface GoodsDetailsViewController () <SelectMediaViewDelegate,OptionsViewDelegate>
@property (nonatomic, strong) SelectMediaView *mediaView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) OptionsView *optionView;

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品详情";
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
    
//    self.mediaView = [[SelectMediaView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 120)];
//    self.mediaView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.mediaView.backgroundColor = [UIColor redColor];
//    self.mediaView.delegate = self;
//    [self.view addSubview:self.mediaView];
//
//    [self.mediaView reloadDataSelectMediaView];
    
    self.optionView = [[OptionsView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 120)];
    self.optionView.delegate = self;
    self.optionView.horizontalCount = 3;
    self.optionView.isWidthFixed = YES;
//    self.optionView.isMultiSelect = YES;
//    self.optionView.maxSelect = 3;
    [self.view addSubview:self.optionView];
}

- (NSArray *)optionsViewData:(OptionsView *)optionsView {
    return @[@"大海",@"天地",@"中的",@"上下",@"左右",@"前后",@"得你"];
}

#pragma mark - SelectMediaViewDelegate
- (NSArray *)dataArrayNumberOfItems:(SelectMediaView *)mediaView {
    return self.dataArray;
}

- (CGSize)collectionMediaView:(SelectMediaView *)mediaView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 100);
}

- (void)selectImageMediaView:(SelectMediaView *)mediaView imageItem:(NSInteger)item {
    NSLog(@"image ----%ld",item);
}

- (void)selectVideoMediaView:(SelectMediaView *)mediaView videoItem:(NSInteger)item {
    NSLog(@"video ----%ld",item);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
