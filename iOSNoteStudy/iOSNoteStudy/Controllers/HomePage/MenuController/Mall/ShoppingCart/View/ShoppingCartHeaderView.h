//
//  ShoppingCartHeaderView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
#import "ShoppingCartProtocol.h"

@interface ShoppingCartHeaderView : UIView

@property (nonatomic, strong) ShopStoreModel *storeModel;

@property (nonatomic, assign) NSInteger section;

@property (nonatomic, assign) id <ShoppingCartProtocol> delegate;

@property (nonatomic, copy) dispatch_block_t selectBlock;

@end
