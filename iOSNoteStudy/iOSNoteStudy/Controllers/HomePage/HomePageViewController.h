//
//  HomePageViewController.h
//  NotesStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//


#import "BaseViewController.h"

typedef NS_OPTIONS(NSUInteger, HomePageType) {
//    HomePageTypeNone     = 0,
    HomePageTypeText1    = 1 << 0,
    HomePageTypeText2    = 1 << 1,
    HomePageTypeText3    = 1 << 2,
};


@interface HomePageViewController : BaseViewController

@end
