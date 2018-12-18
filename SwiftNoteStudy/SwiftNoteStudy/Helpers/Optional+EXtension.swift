//
//  Optional+EXtension.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/12/17.
//  Copyright © 2018 lj. All rights reserved.
//

import Foundation

// MARK: - String
public protocol OptionalString {}
extension String: OptionalString {}
public extension Optional where Wrapped: OptionalString {
    // 对可选类型的String(String?)安全解包
    public var noneNull: String {
        if let value = self as? String {
            return value
        }else {
            return ""
        }
    }
    
    // 解包可选字符串 并对空字符串设置默认值
    // - defaultStr: 默认值
    public func noneNull(defaultStr: String) -> String {
        if self.noneNull.isEmpty {
            return defaultStr
        }else {
            return self.noneNull
        }
    }
}





