//
//  NSObject+String.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/27.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import Foundation

extension NSObject {
    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last! as String
    }
    
    //用于获取cell的reuse identifire
    class var identifire: String {
        return String(format: "%@_identifire", self.nameOfClass)
    }
}

