//
//  ShoppingCartViewController.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/7.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "BaseTableView.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartHeaderView.h"
#import "ShoppingCartOperationView.h"
#import "ShoppingCartModel.h"
#import "ShoppingCartProtocol.h"

static NSString *shoppingCartCell = @"ShoppingCartCell";

@interface ShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource,ShoppingCartProtocol>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ShoppingCartOperationView *operationView;
@property (nonatomic, strong) ShoppingCartModel *shopCartModel;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    [self loadData];
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar - kBarHeight)];
    [self.view addSubview:self.scrollView];
    
    self.tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavbarAndStatusBar - kBottomBarHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 130;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.operationView];
    
    self.rightItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editorItemClick:)];
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopStoreModel *storeModel = self.shopCartModel.shopStoreArray[section];
    return storeModel.shopGoodsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.shopCartModel.shopStoreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:shoppingCartCell];
    if (cell == nil) {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:shoppingCartCell];
    }
    ShopStoreModel *cartModel = self.shopCartModel.shopStoreArray[indexPath.section];
    cell.goodsModel = cartModel.shopGoodsArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ShopStoreModel *storeModel = self.shopCartModel.shopStoreArray[section];
    ShoppingCartHeaderView *headerView = [[ShoppingCartHeaderView alloc]init];
    headerView.storeModel = storeModel;
    headerView.delegate = self;
    headerView.section = section;
    return headerView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) {
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler(YES);
    }];
    
    UIContextualAction *collectionAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"收藏" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler(NO);
    }];
    
    UISwipeActionsConfiguration *swipeActions = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction,collectionAction]];
    return swipeActions;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tableView setEditing:NO animated:YES];
    }];
    
    UITableViewRowAction *collectionAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [tableView setEditing:NO animated:YES];
    }];
    collectionAction.backgroundColor = [UIColor mainColor];
    return @[deleteAction, collectionAction];
}

#pragma mark ShoppingCartProtocol
- (void)selectShoppingCart:(ShoppingCartType)cartType indexPath:(NSIndexPath *)indexPath {
    if (cartType == ShoppingCartTypeRow) {
        [self _goodsSelected:indexPath];
    }else if (cartType == ShoppingCartTypeSection) {
        [self _storeSelected:ShoppingCartTypeSection indexPath:indexPath];
    }else if (cartType == ShoppingCartTypeAll) {
        [self _shoppingCartSelected:ShoppingCartTypeAll];
    }
}

- (void)operationShoppingCart:(ShoppingCartOperationType)operationType {
    if (operationType == ShoppingCartOperationTypePay) {
        NSLog(@"支付");
    }else if (operationType == ShoppingCartOperationTypeDelete) {
        NSLog(@"删除");
    }
}

#pragma mark - Event
- (void)editorItemClick:(UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"编辑"]) {
        self.rightItem.title = @"完成";
        [self.operationView shoppingCartSelect:@"删除" isSelect:self.shopCartModel.isSelect];
    }else if ([item.title isEqualToString:@"完成"]) {
        self.rightItem.title = @"编辑";
        [self.operationView shoppingCartSelect:@"结算" isSelect:self.shopCartModel.isSelect];
    }
}

#pragma mark - Private
- (void)_goodsSelected:(NSIndexPath *)index {
    ShopStoreModel *storeModel = self.shopCartModel.shopStoreArray[index.section];
    ShopGoodsModel *goodsModel = storeModel.shopGoodsArray[index.row];
    if (!goodsModel.isSelect && goodsModel.goodsCount > goodsModel.goodsStock) {
        [[LSAlertUtil alertManager] showPromptInfo:@"该商品库存不足"];
    }else {
        goodsModel.isSelect = !goodsModel.isSelect;
        [self _storeSelected:ShoppingCartTypeRow indexPath:index];
    }
}

- (void)_storeSelected:(ShoppingCartType)cartType indexPath:(NSIndexPath *)index {
    ShopStoreModel *storeModel = self.shopCartModel.shopStoreArray[index.section];
    if (cartType == ShoppingCartTypeSection) {
        storeModel.isSelect = !storeModel.isSelect;
    }
    BOOL isSelectSection = true;
    storeModel.storeAllPrice = 0.0f;
    for (ShopGoodsModel *goodsModel in storeModel.shopGoodsArray) {
        if (cartType == ShoppingCartTypeSection && goodsModel.goodsCount <= goodsModel.goodsStock) {
            goodsModel.isSelect = storeModel.isSelect;
        }
        if (goodsModel.isSelect) {
            storeModel.storeAllPrice += goodsModel.goodsCount * goodsModel.goodsPrice;
        }else {
            isSelectSection = NO;
        }
    }
    storeModel.isSelect = isSelectSection;
    [self _refreshTabelViewSection:index.section];
    [self _shoppingCartSelected:cartType];
}

- (void)_shoppingCartSelected:(ShoppingCartType)cartType {
    self.shopCartModel.shopAllPrice = 0.0;
    if (cartType == ShoppingCartTypeAll) {
        self.shopCartModel.isSelect = !self.shopCartModel.isSelect;
        for (ShopStoreModel *storeModel in self.shopCartModel.shopStoreArray) {
            storeModel.isSelect = self.shopCartModel.isSelect;
            storeModel.storeAllPrice = 0.0;
            for (ShopGoodsModel *goodsModel in storeModel.shopGoodsArray) {
                goodsModel.isSelect = self.shopCartModel.isSelect;
                if (goodsModel.isSelect) {
                    storeModel.storeAllPrice += goodsModel.goodsCount * goodsModel.goodsPrice;
                }
            }
            self.shopCartModel.shopAllPrice +=  storeModel.storeAllPrice;
        }
        [self.tableView reloadData];
    }else {
        BOOL isSelectAll = true;
        for (ShopStoreModel *storeModel in self.shopCartModel.shopStoreArray) {
            self.shopCartModel.shopAllPrice +=  storeModel.storeAllPrice;
            if (!storeModel.isSelect) {
                isSelectAll = NO;
            }
        }
        self.shopCartModel.isSelect = isSelectAll;
    }
    self.operationView.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.shopCartModel.shopAllPrice];
    [self.operationView shoppingCartSelect:@"结算" isSelect:self.shopCartModel.isSelect];
}

//刷新Section
- (void)_refreshTabelViewSection:(NSInteger)section {
    [UIView performWithoutAnimation:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

#pragma mark - Lazy
- (ShoppingCartOperationView *)operationView {
    if (_operationView == nil) {
        _operationView = [[ShoppingCartOperationView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, kBottomBarHeight)];
        _operationView.delegate = self;
        [_operationView shoppingCartSelect:@"结算" isSelect:self.shopCartModel.isSelect];
    }
    return _operationView;
}

- (ShoppingCartModel *)shopCartModel {
    if (_shopCartModel == nil) {
        _shopCartModel = [[ShoppingCartModel alloc]init];
    }
    return _shopCartModel;
}

- (void)loadData {
    NSMutableArray *storeArr = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        ShopStoreModel *storeModel = [[ShopStoreModel alloc]init];
        NSMutableArray *itemArray = [NSMutableArray array];
        storeModel.shopName = @"商店名称商店名称";
        for (int j = 0; j < 4; j ++) {
            ShopGoodsModel *goodsModel = [[ShopGoodsModel alloc]init];
            goodsModel.goodsName = @"这是什么神的";
            goodsModel.goodsImage = @"ddddd";
            goodsModel.goodsAttribute = @"商品描述商品描述";
            goodsModel.goodsCount = 10;
            if (j == 2) {
                goodsModel.goodsStock = 8;
            }else {
                goodsModel.goodsStock = 11;
            }
            goodsModel.goodsPrice = 10.9;
            [itemArray addObject:goodsModel];
        }
        storeModel.shopGoodsArray = itemArray;
        [storeArr addObject:storeModel];
    }
    self.shopCartModel.shopStoreArray = storeArr;
}


@end
