//
//  BaseSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/1/30.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit

class BaseSwiftViewController: UIViewController {

    deinit {
        print(self.description + "释放")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        // Do any additional setup after loading the view.
    }
    
    public func initNavBarBackBtn() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let leftItem = UIBarButtonItem.createBackBarButtonForDelegate(self, action: #selector(backAction(_:)))
        navigationItem.leftBarButtonItem = leftItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Event
    @objc func backAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}


