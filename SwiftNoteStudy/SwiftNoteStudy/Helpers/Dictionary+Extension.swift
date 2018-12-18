//
//  Dictionary+Extension.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2018/12/17.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

// optional nil
extension Dictionary {
    subscript (safe key: Key) -> Value? {
        get {
            return self[key]
        }
        set {
            if "\(String(describing: newValue))" != "Optional(nil)" && "\(String(describing: newValue))" != "Optional(\"nil\")" {
                self[key] = newValue
            }else {
                self[key] = nil
            }
        }
    }
}
