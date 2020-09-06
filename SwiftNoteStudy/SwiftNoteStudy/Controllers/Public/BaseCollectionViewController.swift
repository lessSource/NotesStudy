//
//  BaseCollectionViewController.swift
//  SwiftNoteStudy
//
//  Created by L j on 2020/9/6.
//  Copyright © 2020 lj. All rights reserved.
//

import UIKit

enum PublicClassType: String {
    
    // MARK: - Home
    case animation = "动画"
    
    // MARK: - Release
    
    
    // MARK: - Mine
    
    
    
    var jumpVC: BaseSwiftViewController {
        switch self {
        case .animation:
            return AnimationViewController()
        }
    }
    
    
    
    
}

class BaseCollectionViewController: BaseSwiftViewController {

    public var nameArray: [PublicClassType] {
        return []
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: (Constant.screenWidth - 50)/3, height: 45)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight - Constant.navbarAndStatusBar), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: BaseCollectionViewCell.identifire)
        view.addSubview(collectionView)

    }

//    public func getNameLabelArray() -> [PublicClassType] {
//        return []
//    }
    
}

extension BaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseCollectionViewCell.identifire, for: indexPath) as! BaseCollectionViewCell
        cell.nameLabel.text = nameArray[indexPath.item].rawValue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = nameArray[indexPath.item].jumpVC
        vc.title = nameArray[indexPath.item].rawValue
        pushAndHideTabbar(vc)
    }
    
    
}
