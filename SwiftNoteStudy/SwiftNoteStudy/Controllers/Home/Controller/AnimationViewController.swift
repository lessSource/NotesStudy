//
//  AnimationViewController.swift
//  SwiftNoteStudy
//
//  Created by L j on 2020/9/6.
//  Copyright © 2020 lj. All rights reserved.
//

import UIKit

enum AnimationType: String {
    
    case frame = "大小变化"
    case bounds = "拉伸变化"
    case center = "中心位置"
    case transform = "旋转"
    case alpha = "透明度"
    case backgroundColor = "背景颜色"
    case contentStretch = "拉伸内容"

}

class AnimationViewController: BaseSwiftViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: (Constant.screenWidth - 50)/3, height: 45)
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: 70), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return collectionView
    }()
    
    fileprivate lazy var bodyView: UIView = {
        let bodyView = UIView(frame: CGRect(x: 15, y: 85, width: 100, height: 100))
        bodyView.backgroundColor = UIColor.red
        return bodyView
    }()
    
    fileprivate var dataArray: Array = [AnimationType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initNavBarBackBtn()
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.identifire)
        view.addSubview(collectionView)
        dataArray = [.frame, .bounds, .center, .transform, .alpha, .backgroundColor, .contentStretch]
        view.addSubview(bodyView)
        
    }

}


extension AnimationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.identifire, for: indexPath) as! BaseCollectionViewCell
        cell.nameLabel.text = dataArray[indexPath.row].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        timeAnimation(dataArray[indexPath.row])
    }
        
}

extension AnimationViewController {
    
    /** 包含时间动画 */
    fileprivate func timeAnimation(_ animationType: AnimationType) {
        UIView.animate(withDuration: 3) {
            self.performAnimation(animationType)
        }
    }
    
    /** 带有动画提交回调的动画 */
    fileprivate func timeFinishedAnimation(_ animationType: AnimationType) {
        /**
         * 动画执行时间
         * 执行动画代码块
         * 动画执行完成之后的回调
         */
        UIView.animate(withDuration: 3, animations: {
            self.performAnimation(animationType)
        }) { (finished) in
            self.alertVC("动画完成") {
                
            }
        }
        
    }
    

    /** 可以设置延时时间和过渡效果的动画 */
    fileprivate func timeDelayAnimation(_ animationType: AnimationType) {
        /**
         * 动画执行时间
         * 动画延时开始的事件
         * 动画过渡效果的枚举值
         * 执行动画代码块
         * 动画执行完成之后的回调
         */
        UIView.animate(withDuration: 3, delay: 2, options: .curveLinear, animations: {
            self.performAnimation(animationType)
        }) { (finished) in
            self.alertVC("动画完成") {
                
            }
        }
        
    }
 

    
    
    
    /** 动画执行 */
    fileprivate func performAnimation(_ animationType: AnimationType) {
        
        switch animationType {
        case .frame:
            bodyView.frame = CGRect(x: 30, y: 90, width: 150, height: 150)
        case .bounds:
            bodyView.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        case .center:
            bodyView.center = CGPoint(x: 200, y: 200)
        case .transform:
            bodyView.transform = CGAffineTransform(rotationAngle: 2)
        case .alpha:
            bodyView.alpha = 0.4
        case .backgroundColor:
            bodyView.backgroundColor = UIColor.orange
        case .contentStretch:
            bodyView.contentScaleFactor = 0.6
        }
        
    }
    
    /** 包含时间和动画 */
    fileprivate func animate() {


        
        // Spring动画
        /**
         * 动画执行时间
         * 动画延时开始的事件
         * Spring动画，震动效果，范围0 ~ 1，数值越小震动效果越明显
         * 初始速度，数值越大初始化越快
         * 动画过渡效果的枚举值
         * 执行动画代码块
         * 动画执行完成之后的回调
        */

//        UIView.animate(withDuration: 1.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 100.0, options: .curveLinear, animations: {
//          // 执行动画代码
//        }) { (finished) in
//          // 动画执行完成后的回调
//        }
        
        // Keyframes动画
        /**
         * 动画执行时间
         * 动画延时开始的事件
         * 动画过渡效果：UIViewKeyframeAnimationOption
         * 执行动画代码块
         * 动画执行完成之后的回调
        */

//        UIView.animateKeyframes(withDuration: 1.0, delay: 2.0, options: .repeat, animations: {
//          // 执行动画代码
//        }) { (finished) in
//          // 动画执行完成后的回调
//        }

        /**
         * 动画开始的时间(占总时间的比例)
         * 动画持续时间(占总时间的比例)
         * 执行动画代码块
        */

//        UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.7) {
//          // 执行动画代码
//        }
        
        // 转场动画——从旧视图到新视图的动画效果
        /**
         * 动画作用的View
         * 动画持续时间
         * 动画的过渡效果：UIViewAnimationOptions
         * 执行动画代码
         * 动画执行完成之后的回调
        */

//        UIView.transition(with: animationView, duration: 3, options: .curveLinear, animations: {
//          // 执行动画代码
//        }) { (finished) in
//          // 动画执行完成后的回调
//        }


        /**
         * 动画作用的View：从父视图中移出
         * 动画作用的View：添加到父视图中
         * 动画持续时间
         * 动画的过渡效果：UIViewAnimationOptions
         * 动画执行完成之后的回调
        */

//        UIView.transition(from: animationView, to: animationView, duration: 0.3, options: .curveLinear) { (finished) in
//          // 动画执行完成后的回调
//        }

        // 该动画过程中， fromView会从父视图中移出，并将toView添加到父视图中，注意转场动画的作用对象是父视图(过渡效果体现在父视图上)。

        
    }
    
}
