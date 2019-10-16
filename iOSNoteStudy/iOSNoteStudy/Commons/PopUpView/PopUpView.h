//
//  PopUpView.h
//  iOSNoteStudy
//
//  Created by less on 2018/12/12.
//  Copyright © 2018 lj. All rights reserved.
//

#import "PopUpViewObjeect.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopUpView : ContentView

@property (nonatomic, copy) dispatch_block_t block;

@end


NS_ASSUME_NONNULL_END
