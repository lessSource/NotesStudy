//
//  ShoppingCartCell.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
#import "ShoppingCartProtocol.h"

@interface ShoppingCartCell : UITableViewCell

@property (nonatomic, strong) ShopGoodsModel *goodsModel;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) id <ShoppingCartProtocol> delegate;

@property (nonatomic, copy) dispatch_block_t selectBlock;

@end
