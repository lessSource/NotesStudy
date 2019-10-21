//
//  DropDownMenuView.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2019/3/21.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

protocol DropDownMenuViewDelegate: NSObjectProtocol {
    func dropDownMenuViewSelect() -> String
    
    func dropDownMenuViewArray(_ dataArray: Array<String>)
}

extension DropDownMenuViewDelegate {
    func dropDownMenuViewSelect() -> String {
        return ""
    }
}

class DropDownMenuView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, clickView: UIView) {
        self.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.alpha = 0.2
        App.keyWindow.addSubview(self)
        
        print(clickView.frame)
        print(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
