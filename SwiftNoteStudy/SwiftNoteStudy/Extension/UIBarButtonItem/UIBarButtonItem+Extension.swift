//
//  UIBarButtonItem+Extension.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/2/28.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func createBackBarButtonForDelegate(_ target: Any?, action: Selector) -> UIBarButtonItem {
        
        let backButton: UIButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0, y: 0, width: 54, height: 44)
        backButton.addTarget(target, action: action, for: .touchUpInside)
        backButton.setImage(UIImage(named: "icon_back_w"), for: .normal)
        backButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 20)
        let backItem = UIBarButtonItem(customView: backButton)
        return backItem
    }
    
    
}


extension UIBarButtonItem {
    
}
