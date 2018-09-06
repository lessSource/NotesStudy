//
//  ShoppingCartProtocol.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/1.
//  Copyright © 2018年 lj. All rights reserved.
//

typedef NS_ENUM(NSInteger, ShoppingCartType) {
    ShoppingCartTypeNone,
    /** 商品选择 */
    ShoppingCartTypeRow,
    /** 商铺选择 */
    ShoppingCartTypeSection,
    /** 全选 */
    ShoppingCartTypeAll,
};

typedef NS_ENUM(NSInteger, ShoppingCartOperationType) {
    ShoppingCartOperationTypeNone,
    /** 支付 */
    ShoppingCartOperationTypePay,
    /** 编辑 */
    ShoppingCartOperationTypeEditor,
    /** 完成 */
    ShoppingCartOperationTypeComplete,
    /** 删除 */
    ShoppingCartOperationTypeDelete,
};


#import <Foundation/Foundation.h>

@protocol ShoppingCartProtocol <NSObject>

- (void)selectShoppingCart:(ShoppingCartType)cartType indexPath:(NSIndexPath *)indexPath;

- (void)operationShoppingCart:(ShoppingCartOperationType)operationType;


@end

