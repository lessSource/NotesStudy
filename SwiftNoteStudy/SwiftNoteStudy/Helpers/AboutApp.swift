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
    public static var appName: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    }
    /** 版本 */
    public static var appVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    /** build */
    public static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    /** bundle id */
    public static var bundleIdentifier: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifire"] as! String
    }
    /**  */
    public static var bundelName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    /** appStore地址 */
    public static var appStoreURL: URL {
        return URL(string: "www.baidu.com")!
    }
    /**  */
    public static var appVersionAndBuild: String {
        let version = appVersion, build = appBuild
        return version == build ? "v\(version)" : "\(version)(\(build))"
    }
    /**  */
    public static var IDFA: String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    /**  */
    public static var IDFV: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    public static var keyWindow: UIView {
        return UIApplication.shared.keyWindow ?? UIView()
    }
}


