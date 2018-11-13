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
        //首页
        addChildViewController(HomeSwiftViewController(), title: "首页", imageName: "icon-shouye-44", selectedImage: "icon-shouye-43")
        //社区
        addChildViewController(ReleaseSwiftViewController(), title: "发布", imageName: "icon-shequ-43", selectedImage: "icon-shequ-44")
        //市场
        addChildViewController(MineSwiftViewController(), title: "我", imageName: "icon-faxiang-43", selectedImage: "icon-faxiang-44")
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
