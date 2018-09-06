//
//  ShoppingCartOperationView.h
//  iOSNoteStudy
//
//  Created by Lj on 2018/6/1.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartProtocol.h"

@interface ShoppingCartOperationView : UIView

@property (nonatomic, assign) id <ShoppingCartProtocol> delegate;
@property (nonatomic, strong) UILabel *priceLabel;

- (void)shoppingCartSelect:(NSString *)name isSelect:(BOOL)isSelect;

@end
