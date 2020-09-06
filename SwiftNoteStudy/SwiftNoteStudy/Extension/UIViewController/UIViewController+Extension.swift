//
//  UIViewController+Extension.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/27.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     *    直接加载 xib, 创建ViewController
     *    -returns: UIViewController
     */
    
    class func initFromNib() -> UIViewController {
        let hasNib: Bool = Bundle.main.path(forResource: self.nameOfClass , ofType: "nib") != nil
        guard hasNib else {
            assert(!hasNib, "Invalid parameter")
            return UIViewController()
        }
        return self.init(nibName: self.nameOfClass, bundle: nil)
    }
    
    fileprivate func pushViewController(_ viewController: UIViewController, animated: Bool, hideTabbar: Bool) {
        viewController.hidesBottomBarWhenPushed = hideTabbar
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    /** push */
    public func pushAndHideTabbar(_ viewController: UIViewController) {
        self.pushViewController(viewController, animated: true, hideTabbar: true)
    }
    
    /** present */
    public func presentViewController(_ viewController: UIViewController, completion:(() -> Void)?) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self .present(navigationController, animated: true, completion: completion)
    }
    
    // 提示框
    public func alertVC(_ message: String, confirmAction: @escaping () -> ()) {
        let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "确认", style: .default) { (action) in
            confirmAction()
        }
        alertVC.addAction(confirmAction)
        navigationController?.present(alertVC, animated: true, completion: nil)
    }
}

