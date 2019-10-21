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
    /** 名称 */
    public static var name: String {
        guard let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String else {
            return ""
        }
        return appName
    }

    /** 版本 */
    public static var version: String {
        guard let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String else {
            return ""
        }
        return appVersion
    }
    /** build */
    public static var build: String {
        guard let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String else {
            return ""
        }
        return appBuild
    }
    
    /** bundle id */
    public static var bundleIdentifier: String {
        guard let identifier = Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as? String else {
            return ""
        }
        return identifier
    }
    /**  */
    public static var bundelName: String {
        guard let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            return ""
        }
        return name
    }
    /** appStore地址 */
    public static var appStoreURL: URL {
        return URL(string: "www.baidu.com")!
    }
    /**  */
    public static var versionAndBuild: String {
        let appVersion = version, appBuild = build
        return appVersion == appBuild ? "v\(appVersion)" : "\(appVersion)(\(appBuild))"
    }
    /** 广告标识符 */
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    /** 应用开发商标识符 */
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var keyWindow: UIView {
        return UIApplication.shared.keyWindow ?? UIView()
    }
    
    public static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}


