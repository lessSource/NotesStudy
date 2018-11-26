//
//  UIColor+Extension.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/13.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

extension UIColor {
    
    public static var mainColor: UIColor {
        return withHex(hexString: "#333333")
    }
    public static var textColor: UIColor {
        return withHex(hexString: "#999999")
    }
    
    static func withHex(hexString hex: String, alpha: CGFloat = 1) -> UIColor {
        // 去除空格
        var cString: String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除#
        if cString.hasPrefix("#") {
            cString = (cString as NSString).substring(from: 1)
        }
        if cString.count != 6 {
            return UIColor.gray
        }
        
        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        Scanner(string: cString[0..<2]).scanHexInt32(&red)
        Scanner(string: cString[0..<2]).scanHexInt32(&green)
        Scanner(string: cString[0..<2]).scanHexInt32(&blue)
        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

extension String {
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
}

