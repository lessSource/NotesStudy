//
//  PopUpView.m
//  iOSNoteStudy
//
//  Created by less on 2018/12/12.
//  Copyright © 2018 lj. All rights reserved.
//

#import "PopUpView.h"

@implementation PopUpView



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"dddd");
    [[PopUpViewObjeect sharrPopUpView] cancalContentView:self];
    self.block();
}


@end
