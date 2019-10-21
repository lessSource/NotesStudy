//
//  HomeSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit

class HomeSwiftViewController: BaseSwiftViewController {
    
    fileprivate var redView: UIView = {
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 150, height: 40))
        redView.backgroundColor = UIColor.red
        return redView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _ = DropDownMenuView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight), clickView: redView)
    }
}


