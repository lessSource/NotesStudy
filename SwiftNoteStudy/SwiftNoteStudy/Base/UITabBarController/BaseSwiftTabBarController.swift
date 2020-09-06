//
//  BaseSwiftTabBarController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit

class BaseSwiftTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //MARK:-添加子控制器
        //系统控件
        addChildViewController(HomeSwiftViewController(), title: "系统控件", imageName: "icon_norHomePage", selectedImage: "icon_selHomePage")
        //三方用法
        addChildViewController(ReleaseSwiftViewController(), title: "三方用法", imageName: "icon_norHomePage", selectedImage: "icon_selHomePage")
        //通用界面
        addChildViewController(MineSwiftViewController(), title: "通用界面", imageName: "icon_norHomePage", selectedImage: "icon_selHomePage")
        
        tabBar.isTranslucent = false
        tabBar.shadowImage = UIImage.colorCreateImage(.lineColor, size: CGSize(width: Constant.screenWidth, height: Constant.lineHeight))
        tabBar.backgroundImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addChildViewController(_ childController: UIViewController,title:String,imageName:String,selectedImage:String) {
        //1.设置子控制器的tabBarItem的标题图片
        
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImage)
        
        //添加子控制器        
        let chidNav = BaseSwiftNavigationController(rootViewController: childController)
        addChildViewController(chidNav)
    }
}
