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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
}
