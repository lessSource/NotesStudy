//
//  PopUpController.h
//  NotesStudy
//
//  Created by Lj on 2018/2/5.
//  Copyright © 2018年 lj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopUpController : NSObject


- (void)presentContentView:(UIView *)contentView;

@end



@interface UIViewController (PopUpController)

@property (nonatomic, strong) PopUpController *popUpController;

@end
