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

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
//        let rect = CGRect.init(x: 0, y: 0, width: 100, height: 10)
//        UIGraphicsBeginImageContext(rect.size)
//        let content = UIGraphicsGetCurrentContext()
//        content?.setFillColor(UIColor.red.cgColor)
//        content?.fill(rect)
//        let img = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        navigationController?.navigationBar.shadowImage = img
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
