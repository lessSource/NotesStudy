//
//  BaseSwiftNavigationController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit

class BaseSwiftNavigationController: UINavigationController {

    private let barBackgronudView = UIView()
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //        setUpUI()
    }
    
    private func setUpUI() {
        barBackgronudView.frame = CGRect(x: 0, y: -20, width: view.frame.size.width, height: 40)
        navigationBar.isTranslucent = true
        navigationBar.barStyle = .default

        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(red: 255.0/255.0, green: 70.0/255.0, blue: 93.0/255.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 251.0/255.0, green: 108.0/255.0, blue: 42.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [color1 ,color2]
        gradientLayer.locations = [0.1, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40)
        barBackgronudView.layer.insertSublayer(gradientLayer, above: gradientLayer)
        
        navigationBar.tintColor = UIColor.white
        navigationBar.barTintColor = UIColor.clear
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        navigationBar.setBackgroundImage(convertViewToImage(view: barBackgronudView), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        
    }
    
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
}
