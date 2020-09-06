//
//  Renderer.m
//  iOSNoteStudy
//
//  Created by L j on 2020/8/19.
//  Copyright © 2020 lj. All rights reserved.
//

#import "Renderer.h"

@implementation Renderer
{
    id<MTLDevice> _device;
    id<MTLCommandQueue> _commandQueue;
}

static BOOL growing = true;
static NSUInteger primaryChannel = 0;
static float colorChannels[] = {1.0, 0.0, 0.0, 1.0};
 
typedef struct {
    float red, green, blue, alphe;
} Color;

- (id)initWithMatalKitView:(MTKView *)mtkView {
    if (self = [super init]) {
//        _de
        _device = mtkView.device;
        _commandQueue = [_device newCommandQueue];
        
    }
    return self;
}

- (Color)makeFancyColor {
    

    const float DynamicColorRate = 0.015;
    
    if (growing) {
        NSUInteger dynamicChannelIndex = (primaryChannel + 1) % 3;
        colorChannels[dynamicChannelIndex] += DynamicColorRate;
        
        if (colorChannels[dynamicChannelIndex] >= 1.0) {
            growing = false;
            primaryChannel = dynamicChannelIndex;
        }
    }else {
        NSUInteger dynamicChannelIndex = (primaryChannel + 2) % 3;
        colorChannels[dynamicChannelIndex] -= DynamicColorRate;
        
        if (colorChannels[dynamicChannelIndex] <= 0.0) {
            growing = true;
        }
    }
    
    Color color;
    color.red = colorChannels[0];
    color.green = colorChannels[1];
    color.blue = colorChannels[2];
    color.alphe = colorChannels[3];
    
    return color;
}

- (void)drawInMTKView:(MTKView *)view {
    //1. 获取颜色值
    Color color = [self makeFancyColor];
    
    //2. 设置view的clearColor
    view.clearColor  = MTLClearColorMake(color.red, color.green, color.blue, color.alphe);
    
    //3. Create a new command buffer for each render pass to the current drawable
    //使用MTLCommandQueue 创建对象并且加入到MTCommandBuffer对象中去.
    //为当前渲染的每个渲染传递创建一个新的命令缓冲区
    id<MTLCommandBuffer> commBuffer = [_commandQueue commandBuffer];
    commBuffer.label = @"MyCommand";
        
    //4.从视图绘制中,获得渲染描述符
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    
    //5.判断renderPassDescriptor 渲染描述符是否创建成功,否则则跳过任何渲染.
    if (renderPassDescriptor != nil) {
        //6.通过渲染描述符renderPassDescriptor创建MTLRenderCommandEncoder 对象
        id<MTLRenderCommandEncoder> renderEncoder = [commBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";
        
        //7.我们可以使用MTLRenderCommandEncoder 来绘制对象,但是这个demo我们仅仅创建编码器就可以了,我们并没有让Metal去执行我们绘制的东西,这个时候表示我们的任务已经完成.
        //即可结束MTLRenderCommandEncoder 工作
        [renderEncoder endEncoding];
        
        /*
         当编码器结束之后,命令缓存区就会接受到2个命令.
         1) present
         2) commit
         因为GPU是不会直接绘制到屏幕上,因此你不给出去指令.是不会有任何内容渲染到屏幕上.
        */
        //8.添加一个最后的命令来显示清除的可绘制的屏幕
        [commBuffer presentDrawable:view.currentDrawable];
        
        //9.在这里完成渲染并将命令缓冲区提交给GPU
        [commBuffer commit];
    }
}

//当MTKView视图发生大小改变时调用
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}

@end
