//
//  PopUpViewManager.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/12/17.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

enum PopUpViewDirectionType {
    case up
    case down
    case left
    case right
    case center
}

class PopUpViewManager  {
    
    static let sharedInstance = PopUpViewManager()
    
    fileprivate lazy var subBackView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight))
        return view
    }()
    
    fileprivate var maskView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight))
        view.backgroundColor = UIColor.black
        view.alpha = 0
        return view
    }()
    
    fileprivate var contentView: PopUpContentView!
    fileprivate var directionType: PopUpViewDirectionType = .down
    
    private init() {
        initView()
    }
}

extension PopUpViewManager {
    
    // MARK:- initView
    fileprivate func initView() {
        let tapGester: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backViewClick))
        tapGester.numberOfTapsRequired = 1
        maskView.addGestureRecognizer(tapGester)
        
        subBackView.addSubview(maskView)
    }
    
    // MARK:- public
    public func presentContentView(_ contentView: PopUpContentView, dircetionType: PopUpViewDirectionType = .down, backView: UIView = App.keyWindow) {
        directionType = dircetionType
        subBackView.addSubview(contentView)
        contentView.willShowView()
        self.contentView = contentView
        UIView.animate(withDuration: 0.5) {
            self.contentView.alpha = 1
            self.maskView.alpha = 0.5
        }
        backView.addSubview(subBackView)
        if dircetionType == .center {
            self.contentView.layer.add(alertViewShowAnimation(), forKey: nil)
        }else {
            showAnimation(dircetionType)
        }
    }
    
    public func cancalContentView(_ contentView: PopUpContentView, dircetionType: PopUpViewDirectionType = .down) {
        if self.contentView == nil { return }
        cancelAnimation(directionType)
    }
    
    
    // MARK:- private
    fileprivate func showAnimation(_ directionType: PopUpViewDirectionType) {
        switch directionType {
        case .up:
            contentView.transform = CGAffineTransform(translationX: 0, y: -contentView.height)
        case .down:
            contentView.transform = CGAffineTransform(translationX: 0, y: contentView.height)
        case .left:
            contentView.transform = CGAffineTransform(translationX: -contentView.width, y: 0)
        case .right:
            contentView.transform = CGAffineTransform(translationX: contentView.width, y: 0)
        case .center: break
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (finushed) in
            self.contentView.didShwoView()
        }
    }
    
    fileprivate func cancelAnimation(_ directionType: PopUpViewDirectionType) {
        contentView.willCancelView()
        UIView.animate(withDuration: 0.5, animations: {
            switch directionType {
            case .up:
                self.contentView.transform = CGAffineTransform(translationX: 0, y: -self.contentView.height)
            case .down:
                self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.height)
            case .left:
                self.contentView.transform = CGAffineTransform(translationX: -self.contentView.width, y: 0)
            case .right:
                self.contentView.transform = CGAffineTransform(translationX: self.contentView.width, y: 0)
            case .center: break
            }
            self.maskView.alpha = 0.0;
            self.contentView.alpha = 0.0;
        }) { (finished) in
            self.contentView.didCancelView()
            self.contentView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.contentView.removeFromSuperview()
            self.contentView = nil
            self.subBackView.removeFromSuperview()
        }
    }
    
    fileprivate func alertViewShowAnimation() -> CAAnimation {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.keyTimes = [0, 0.5, 1.0]
        scaleAnimation.values = [0.01, 0.5, 1.0]
        scaleAnimation.duration = 0.5
        
        let opacityAnimaton = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimaton.keyTimes = [0, 0.5, 1]
        opacityAnimaton.values = [0.01, 0.5, 1.0]
        opacityAnimaton.duration = 0.5
        
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, opacityAnimaton]
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.duration = 0.5
        return animation
    }
    
    // MARK:- Event
    @objc func backViewClick() {
        cancalContentView(contentView, dircetionType: directionType)
        contentView.endEditing(true)
    }
    
}




class PopUpContentView: UIView {
    
    public func willShowView() { }
    
    public func didShwoView() { }
    
    public func willCancelView() { }
    
    public func didCancelView() { }
}


