//
//  ContentView.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/2/14.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

class ContentView: PopUpContentView {
    
    override func willShowView() {
        super.willShowView()
        print("willShowView")
    }
    
    override func didShwoView() {
        super.didShwoView()
        print("didShwoView")
    }
    
    override func willCancelView() {
        super.willCancelView()
        print("willCancelView")
    }
    
    override func didCancelView() {
        super.didCancelView()
        print("didCancelView")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
