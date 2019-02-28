//
//  UIImage+Extension.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/2/28.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit
import Accelerate

extension UIImage {
    private func convertViewToImage(view: UIView) -> UIImage {
        let size = view.bounds.size
        //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数屏幕密度
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        //把控制器的view的内容画到上下文中
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        //从上下文中生成一张图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return image!
    }
    
    public class func colorCreateImage(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        let content: CGContext = UIGraphicsGetCurrentContext()!
        content.setFillColor(color.cgColor)
        content.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
    func imageByRemoveWhiteBg() -> UIImage? {
        let colorMasking: [CGFloat] = [222, 255, 222, 255, 222, 255]
        return transparentColor(colorMasking: colorMasking)
    }
    
    func transparentColor(colorMasking:[CGFloat]) -> UIImage? {
        if let rawImageRef = self.cgImage {
            UIGraphicsBeginImageContext(self.size)
            if let maskedImageRef = rawImageRef.copy(maskingColorComponents: colorMasking) {
                let context: CGContext = UIGraphicsGetCurrentContext()!
                context.translateBy(x: 0.0, y: self.size.height)
                context.scaleBy(x: 1.0, y: -1.0)
                context.draw(maskedImageRef, in: CGRect(x:0, y:0, width:self.size.width,
                                                        height:self.size.height))
                let result = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return result
            }
        }
        return nil
    }
    
    // 高斯模糊
    func gaussianBlur(_ blurAmount: CGFloat) -> UIImage {
        var levelValue: CGFloat = blurAmount
        // 高斯模糊参数（0-1）之间，超出范围强制转成0.5
        if levelValue < 0.0 || levelValue > 1.0 {
            levelValue = 0.5
        }
        
        // boxSize 必须大于0
        var boxSize = Int(levelValue * 40)
        boxSize = boxSize - (boxSize % 2) + 1
        
        guard let _cgImage = self.cgImage else { return self }
        // 图像缓存：输入缓存、输出缓存
        var inBuffer = vImage_Buffer()
        var outBuffer = vImage_Buffer()
        var error = vImage_Error()
        
        let inProvider = _cgImage.dataProvider
        let inBitmapData = inProvider?.data
        
        
        inBuffer.width = vImagePixelCount(_cgImage.width)
        inBuffer.height = vImagePixelCount(_cgImage.height)
        inBuffer.rowBytes = _cgImage.bytesPerRow
        inBuffer.data = UnsafeMutableRawPointer(mutating: CFDataGetBytePtr(inBitmapData!))
        
        // 像素缓存
        let pixelBuffer = malloc(_cgImage.bytesPerRow * _cgImage.height)
        outBuffer.data = pixelBuffer
        outBuffer.width = vImagePixelCount(_cgImage.width)
        outBuffer.height = vImagePixelCount(_cgImage.height)
        outBuffer.rowBytes = _cgImage.bytesPerRow
        
        //中间缓存区，抗锯齿
        let pixelBuffer2 = malloc(_cgImage.bytesPerRow * _cgImage.height)
        var outBuffer2 = vImage_Buffer()
        outBuffer2.data = pixelBuffer2
        outBuffer2.width = vImagePixelCount(_cgImage.width)
        outBuffer2.height = vImagePixelCount(_cgImage.height)
        outBuffer2.rowBytes = _cgImage.bytesPerRow
        
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        error = vImageBoxConvolve_ARGB8888(&outBuffer2, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        if error != kvImageNoError {
            debugPrint(error)
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let ctx = CGContext(data: outBuffer.data, width: Int(outBuffer.width), height: Int(outBuffer.height), bitsPerComponent: 8, bytesPerRow: outBuffer.rowBytes, space: colorSpace, bitmapInfo: _cgImage.bitmapInfo.rawValue)
        
        let finalCgImage = ctx!.makeImage()
        let finalImage = UIImage(cgImage: finalCgImage!)
        
        free(pixelBuffer!)
        free(pixelBuffer2!)
        
        return finalImage
    }

}


