//
//  ShoppingCartModel.m
//  iOSNoteStudy
//
//  Created by Lj on 2018/5/30.
//  Copyright © 2018年 lj. All rights reserved.
//

#import "ShoppingCartModel.h"

@implementation ShoppingCartModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"shopStoreArray" : [ShopStoreModel class]};
}

@end

@implementation ShopStoreModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"shopGoodsArray" : [ShopGoodsModel class]};
}


@end


@implementation ShopGoodsModel


@end
