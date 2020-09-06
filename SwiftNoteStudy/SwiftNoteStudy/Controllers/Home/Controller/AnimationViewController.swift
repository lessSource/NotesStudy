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
        animate()
    }
        
}

extension AnimationViewController {
    
    /** 包含时间和动画 */
    fileprivate func animate() {
        
//        UIView.animate(withDuration: 3) {
//            self.bodyView.frame = CGRect(x: 15, y: 85, width: 150, height: 150)
//        }
        
        UIView.animate(withDuration: 3.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 100.0, options: .curveLinear, animations: {
          // 执行动画代码
//            self.bodyView.frame = CGRect(x: 15, y: 100, width: 150, height: 150)
            self.bodyView.transform = CGAffineTransform(rotationAngle: 130)
            
        }) { (finished) in
          // 动画执行完成后的回调
            self.alertVC("动画完成") {
                           
                       }
        }
        
//        UIView.animate(withDuration: 3, animations: {
//            self.bodyView.frame = CGRect(x: 15, y: 85, width: 150, height: 150)
//        }) { (finished) in
//            self.alertVC("动画完成") {
//
//            }
//        }
        
    }
    
}
