//
//  AboutApp.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/27.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import AdSupport

public struct App {
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifire"] as! String
    }
    
    public static var bundelName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static var appStoreURL: URL {
        return URL(string: "www.baidu.com")!
    }
    
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "\(version)(\(build))"
    }
    
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    public static var screenSattusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    public static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.main.bounds.size.height - screenSattusBarHeight
        }else {
            return UIScreen.main.bounds.size.width - screenSattusBarHeight
        }
    }
}





















