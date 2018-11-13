//
//  Constant.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/13.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

struct Constant {
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.main.bounds.size.height - statusHeight
        }else {
            return UIScreen.main.bounds.size.width - statusHeight
        }
    }
    
    public static var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    public static var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    public static var statusHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var topBarHeight: CGFloat {
        return 44.0
    }
    
    public static var navbarAndStatusBar: CGFloat {
        return (statusHeight + topBarHeight)
    }
    
    public static var bottomBarHeight: CGFloat {
        return UIDevice.isIphone_X ? 83.0 : 49.0
    }
    
    public static var barHeight: CGFloat {
        return UIDevice.isIphone_X ? 34.0 : 0.0
    }
    
    public static var sizeScale: CGFloat {
        return screenWidth > 320 ? screenWidth/375.0 : 1
    }
}
