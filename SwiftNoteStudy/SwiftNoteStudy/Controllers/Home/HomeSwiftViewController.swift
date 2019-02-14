//
//  HomeSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit
import Then

extension String {
    func stringHash() -> Int {
        var hash: Int64 = 0
        for i in 0 ..< self.count {
            hash = (hash << 4) + Int64((self as NSString).character(at: i))
            let x = hash & Int64.init(0xF0000000)
            if x != 0 {
                hash ^= (x >> 24)
                hash &= ~x
            }
        }
        hash = (hash & Int64.init(0x7FFFFFFF))
        hash = hash % 2147483647
        return Int(hash)
    }
}


class HomeSwiftViewController: BaseSwiftViewController, SelectMediaViewDelegate, ShowImageProtocol, UIViewControllerTransitioningDelegate,HomePageMenuDelegate,HomePageMenuDataSource, PromptViewDelegate {
    
    lazy var contentView: ContentView = {
        let contentView = ContentView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        contentView.center = CGPoint(x: Constant.screenWidth/2, y: Constant.screenHeight/2)
        return contentView
    }()
    
    var menuView: HomePageMenuView!
    var mediaView: SelectMediaView!
    fileprivate var number: Int = 0
    
    fileprivate lazy var lineView: UIView = {
        let lineview = UIView(frame: CGRect(x: Constant.screenWidth/2, y: 200, width: 5, height: 5))
        lineview.backgroundColor = UIColor.black
        view.addSubview(lineview)
        return lineview
    }()

    private var delegate: ModelAnimationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        dddda()
        CacheObject.sharedInstance.cacheModel.token = "ddddd"
        CacheObject.sharedInstance.save()
//        CacheObject.sharedInstance.c
        
        print(CacheObject.sharedInstance.cacheModel.token)
        
        
        view.backgroundColor = UIColor.textColor

        menuView = HomePageMenuView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 70))
        menuView.isAdaptiveHeight = true
        menuView.column = 5

        menuView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        menuView.itemSizeHeight = 80
        menuView.interitemSpacing = 10
        menuView.lineSpacing = 10

        menuView.menuDataSource = self
        menuView.menuDelegate = self
        view.addSubview(menuView)

        
//        mediaView = SelectMediaView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 70))
////        mediaView.isEditor = false
//        mediaView.isAdaptiveHeight = true
//        mediaView.mediaDelegate = self
//        mediaView.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
//        mediaView.interitemSpacing = 5
//        mediaView.lineSpace = 5
//        view.addSubview(mediaView)
//        let _ = self.view.placeholderShow(true).placeholderImageColor(UIColor.brown)
        
//        view.placeholderShow(true)
        view.placeholderShow(true) { (promptView) in
            promptView.delegate = self
            promptView.title("说了没有数据")
        }
    }
    
    func promptViewImageClick(_ promptView: PromptView) {
//        PopUpViewManager.sharedInstance.presentContentView(contentView, backView: view)
//        PopUpViewManager.sharedInstance.presentContentView(contentView)
//        PopUpViewManager.sharedInstance.presentContentView(contentView, dircetionType: .up)
          PopUpViewManager.sharedInstance.presentContentView(contentView, dircetionType: .center, backView: view)

    }

    func mediaViewImage(_ mediaView: SelectMediaView) -> [SelectMediaImage] {
        return ["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao",UIImage(named: "hp_pc_bacao")!]
    }
//
//    func mediaView(_ mediaView: SelectMediaView, didSelectForItemAt item: Int) {
////        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: item)
//        let cell = mediaView.cellForItem(at: IndexPath(item: item, section: 0)) as! SelectMediaCollectionViewCell
//        delegate = ModelAnimationDelegate(originalView: cell.imageView)
//        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: item, delegate: delegate!)
//    }
    
    func menuViewName(_ menuView: HomePageMenuView) -> [String] {
        return ["菜单1","菜单2","菜单3","菜单4","菜单5","菜单2","菜单3","菜单4","菜单5"]
    }

    func menuViewImage(_ menuView: HomePageMenuView) -> [String] {
        return ["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","","hp_pc_bacao","hp_pc_bacao"]
    }

    func menuViewNumber(_ menuView: HomePageMenuView) -> [Int] {
        return [2,2,3,0,99,123,2,0,222]
    }
    
    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
//        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: 0)
//        showImages(["hp_pc_bacao","hp_pc_bacao"], currentIndex: 0, delegate: ModelAnimationDelegate(originalView: <#T##UIImageView#>))

    }
    
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell, ItemAt indexPath: IndexPath) {
        let cell = collectionCell as! HomePageMenuCell
//        delegate = ModelAnimationDelegate.reset(delegate, imageView: cell.iconImage)

//        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: 0, delegate: delegate!)
        print(cell)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let imagePicker: UIImagePickerController = UIImagePickerController()
//        imagePicker.cameraHandle { (success, msg) in
//            let cameraQR = CameraQRViewController()
//            self.pushAndHideTabbar(cameraQR)
//        }
//        PopUpViewManager.sharedInstance.presentContentView(contentView)
//        PopUpViewManager.sharedInstance.presentContentView(contentView, backView: view)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dddda() {
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.red
        view.layer.addSublayer(backgroundView.layer)
        
        let scanZomeBack = UIImageView(frame: CGRect(x: 100, y: 200, width: Constant.screenWidth - 200, height: Constant.screenWidth - 200))
        scanZomeBack.backgroundColor = UIColor.clear
        view.addSubview(scanZomeBack)
        
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = kCAFillRuleEvenOdd // 奇偶显示规则
        let basicPath = UIBezierPath(rect: view.frame) // 底层
        let maskPath = UIBezierPath(roundedRect: scanZomeBack.frame, cornerRadius: (Constant.screenWidth - 200)/2)
        basicPath.append(maskPath) // 重叠
        maskLayer.path = basicPath.cgPath
        backgroundView.layer.mask = maskLayer
        
//        lineViewAnimation()

        let greenView = UIView(frame: CGRect(x: Constant.screenWidth/2, y: 200, width: 1, height: Constant.screenWidth - 200))
        greenView.backgroundColor = UIColor.green
        view.addSubview(greenView)
        let height: Int = Int((Constant.screenWidth - 200)/2)
        
        let top: CGFloat = 0
        let width: CGFloat = top * (Constant.screenWidth - 200) - top * top
        let x: CGFloat = Constant.screenWidth/2 - sqrt(width)
        let blueView = UIView(frame: CGRect(x: x, y: 200 + top, width: sqrt(width) * 2, height: 1))
        blueView.backgroundColor = UIColor.blue
        view.addSubview(blueView)
        
        UIView.animate(withDuration: 2) {
            let ddd: CGFloat = (Constant.screenWidth - 200)/2
            let width1: CGFloat = ddd * (Constant.screenWidth - 200) - ddd * ddd
            let x1: CGFloat = Constant.screenWidth/2 - sqrt(width1)
            blueView.frame = CGRect(x: x1, y: 200 + ddd, width: sqrt(width1) * 2, height: 1)
        }
        
        
//        for i in 0 ... height {
//            let top: CGFloat = CGFloat(i)
//            let width: CGFloat = top * (Constant.screenWidth - 200) - top * top
//            let x: CGFloat = Constant.screenWidth/2 - sqrt(width)
//            let blueView = UIView(frame: CGRect(x: x, y: 200 + top, width: sqrt(width) * 2, height: 1))
//            blueView.backgroundColor = UIColor.blue
//            view.addSubview(blueView)
//        }
//

        
        
//        lineView.layer.add(showAnimation(scanZomeBack), forKey:"Move")
        
    }
    
    
    fileprivate func showAnimation(_ view: UIView) -> CAAnimation {
        
        let orbit = CAKeyframeAnimation(keyPath:"position")
        orbit.duration = 3
        orbit.path = CGPath(ellipseIn: view.frame, transform: nil)
        orbit.calculationMode = kCAAnimationPaced
        orbit.rotationMode = kCAAnimationRotateAuto
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleAnimation.duration = 1.5
        scaleAnimation.values = [1,(Constant.screenWidth - 200)/4]
        
        let scaleAnimation1 = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleAnimation1.duration = 1.5
        scaleAnimation1.beginTime = 1.5
        scaleAnimation1.values = [(Constant.screenWidth - 200)/4,1]

        let animation = CAAnimationGroup()
        animation.animations = [orbit,scaleAnimation,scaleAnimation1]
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = HUGE
        animation.duration = 3
        return animation
    }
    
    
    
//    func lineViewAnimation() {
//        UIView.animate(withDuration: TimeInterval.pi/2, animations: {
//            self.lineView.width = Constant.screenWidth - 200
//            self.lineView.center = CGPoint(x: Constant.screenWidth/2, y: Constant.screenWidth - 100)
//        }) { (finish) in
//            self.lineViewButtonAnimation()
//        }
//    }
//
//    func lineViewButtonAnimation()  {
//        UIView.animate(withDuration: TimeInterval.pi/2, animations: {
//            self.lineView.width = 1
//            self.lineView.center = CGPoint(x: Constant.screenWidth/2, y: Constant.screenWidth)
//        }) { (finish) in
//            self.lineView.center = CGPoint(x: Constant.screenWidth/2, y: 200)
//            self.lineViewAnimation()
//        }
//    }
    
    
    fileprivate func banzhuan() {
//        banzhuan()
    }
    
    
}


