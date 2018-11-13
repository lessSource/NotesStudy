//
//  HomeSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit
import Then

class HomeSwiftViewController: BaseSwiftViewController, HomePageMenuDataSource {
    func menuViewName(_ menuView: HomePageMenuView) -> [String] {
        return ["菜单1","菜单2","菜单3","菜单4","菜单5"]
    }
    
    func menuViewImage(_ menuView: HomePageMenuView) -> [String] {
        return ["菜单1","菜单2"]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "首页"
        
        let menuView = HomePageMenuView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 100))
        menuView.backgroundColor = UIColor.red
        menuView.itemSizeHeight = 50
        menuView.interitemSpacing = 10
        menuView.lineSpacing = 10
        
        menuView.menuDataSource = self
        view.addSubview(menuView)
        
        menuView.frame = CGRect().with({ (rect) in
            rect.size.width = 100
            rect.size.height = 100
        })
        
        menuView.reloadData()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
