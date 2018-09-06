//
//  ShoppingCartModel.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ShopGoodsModel, ShopStoreModel;

@interface ShoppingCartModel : NSObject
/** 购物车名称 */
@property (nonatomic, strong) NSString *shopCartName;
/** 是否全选 */
@property (nonatomic, assign) BOOL isSelect;
/** 购物车总价 */
@property (nonatomic, assign) CGFloat shopAllPrice;
/** 店铺 */
@property (nonatomic, strong) NSArray <ShopStoreModel *> *shopStoreArray;


@end

@interface ShopStoreModel: NSObject

/** 店铺名称 */
@property (nonatomic, strong) NSString *shopName;
/** 店铺图片 */
@property (nonatomic, strong) NSString *shopImage;
/** 是否选中 */
@property (nonatomic, assign) BOOL isSelect;
/** 店铺总价 */
@property (nonatomic, assign) CGFloat storeAllPrice;
/** 商品 */
@property (nonatomic, strong) NSArray <ShopGoodsModel *> *shopGoodsArray;

@end


@interface ShopGoodsModel: NSObject
/** 商品名称 */
@property (nonatomic, strong) NSString *goodsName;
/** 商品图片 */
@property (nonatomic, strong) NSString *goodsImage;
/** 商品描述 */
@property (nonatomic, strong) NSString *goodsAttribute;
/** 商品数量 */
@property (nonatomic, assign) NSInteger goodsCount;
/** 商品价格 */
@property (nonatomic, assign) CGFloat goodsPrice;
/** 商品库存 */
@property (nonatomic, assign) NSInteger goodsStock;
/** 是否选中 */
@property (nonatomic, assign) BOOL isSelect;

@end
