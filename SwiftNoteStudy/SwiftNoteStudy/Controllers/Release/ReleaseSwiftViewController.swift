//
//  ReleaseSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//


import UIKit

struct TestStruct {
    var name: String
    var number: Int
}

class ReleaseSwiftViewController: BaseSwiftViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = [1,2,3,4,5,6,7,8,9]
        let sliceArray = array[1..<6]
        print(sliceArray)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ReleaseSwiftViewController.userDidTakeScreenshot), name: .UIApplicationUserDidTakeScreenshot, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    @objc func userDidTakeScreenshot() {
        // 当前屏幕的image
        let image = imageWithScrrnshot()
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 320, height: 640))
        imageView.image = image
        view.addSubview(imageView)
    }

    // 获取当前屏幕图片
    func imageWithScrrnshot() -> UIImage? {
        let imageData = dataWithScreenshotInPNGFormat()
        return UIImage(data: imageData)
    }
    
    // 截取当前屏幕
    func dataWithScreenshotInPNGFormat() -> Data {
        var imageSize = CGSize.zero
        let screenSize = UIScreen.main.bounds.size
        let orientation = UIApplication.shared.statusBarOrientation
        if UIInterfaceOrientationIsPortrait(orientation) {
            imageSize = screenSize
        }else {
            imageSize = CGSize(width: screenSize.height, height: screenSize.width)
        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        for window in UIApplication.shared.windows {
            context?.saveGState()
            context?.translateBy(x: window.x, y: window.y)
            context?.concatenate(window.transform)
            context?.translateBy(x: -window.width * window.layer.anchorPoint.x, y: -window.height * window.layer.anchorPoint.y)

            if orientation == UIInterfaceOrientation.landscapeLeft {
                context?.rotate(by: CGFloat.pi/2)
                context?.translateBy(x: 0, y: -imageSize.width)
            }else if orientation == .landscapeRight {
                context?.rotate(by: -CGFloat.pi/2)
                context?.translateBy(x: -imageSize.height, y: 0)
            }else if orientation == .portraitUpsideDown {
                context?.rotate(by: -CGFloat.pi)
                context?.translateBy(x: -imageSize.width, y: -imageSize.height)
            }
            if window.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }else {
                window.layer.render(in: context!)
            }
            context?.restoreGState()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImagePNGRepresentation(image!)!
        
    }
 */
    
}
