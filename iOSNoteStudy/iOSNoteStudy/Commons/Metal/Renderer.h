//
//  Renderer.h
//  iOSNoteStudy
//
//  Created by L j on 2020/8/19.
//  Copyright © 2020 lj. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MetalKit;

NS_ASSUME_NONNULL_BEGIN

@interface Renderer : NSObject <MTKViewDelegate>

- (id)initWithMatalKitView:(MTKView *)mtkView;

@end

NS_ASSUME_NONNULL_END
