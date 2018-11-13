//
//  HomePageMenuView.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/2.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

protocol HomePageMenuDelegate: NSObjectProtocol {
    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath)
    
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell,ItemAt indexPath: IndexPath)
}

protocol HomePageMenuDataSource: NSObjectProtocol {
    /** 名字 */
    func menuViewName(_ menuView: HomePageMenuView) -> [String]
    /** 图片 */
    func menuViewImage(_ menuView: HomePageMenuView) -> [String]
    
    /** 消息条数 */
    func menuViewNumber(_ menuView: HomePageMenuView) -> [Int]
    /** cell大小 */
    func menuViewSize(_ menuView: HomePageMenuView, forItemAt indexPath: IndexPath) -> CGSize
    
}

extension HomePageMenuDelegate {
    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath) {}
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell,ItemAt indexPath: IndexPath) {}
}

extension HomePageMenuDataSource {
    func menuViewNumber(_ menuView: HomePageMenuView) -> [Int] {
        return [0]
    }
    
    func menuViewSize(_ menuView: HomePageMenuView, forItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.zero
    }
}


class HomePageMenuView: UICollectionView {
    weak var menuDelegate: HomePageMenuDelegate?
    weak var menuDataSource: HomePageMenuDataSource?
    /** 横向数量 */
    public var column: Int = 4
    /** 横向间隔 */
    public var interitemSpacing: CGFloat = 1 {
        didSet {
            flowLayout.minimumInteritemSpacing = interitemSpacing
        }
    }
    /** 纵向间距 */
    public var lineSpacing: CGFloat = 1 {
        didSet {
            flowLayout.minimumLineSpacing = lineSpacing
        }
    }
    
    /** itemHeight */
    public var itemSizeHeight: CGFloat = 50
    
    fileprivate let CorrectNumber: CGFloat = 0.2
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    fileprivate var itemSize: CGSize = CGSize.zero
    fileprivate var nameArray: [String] = [String]()
    fileprivate var iconArray: [String] = [String]()
    fileprivate var numberArray: [Int] = [Int]()

    deinit {
        print("----deinit------")
    }
    
    convenience init(frame: CGRect) {
        self.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = UIColor.clear
        flowLayout = layout as? UICollectionViewFlowLayout
        collectionViewLayout = layout
        setUpUI()
    }
    
    fileprivate func setUpUI() {
        self.delegate = self
        self.dataSource = self
        self.alwaysBounceVertical = false
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.minimumLineSpacing = lineSpacing

        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
        } else {
        }
        self.register(HomePageMenuCell.self, forCellWithReuseIdentifier: HomePageMenuCell.identifire)
    }
    
    override func reloadData() {
        super.reloadData()
        
        let allWidth: CGFloat = frame.width - CGFloat((column - 1)) * interitemSpacing - CorrectNumber
        self.itemSize = CGSize(width: allWidth/CGFloat(column), height: itemSizeHeight)
        nameArray = menuDataSource?.menuViewName(self) ?? []
        if nameArray.count == 0 { frame.size.height = 0 }
        
        if let menuData = menuDataSource {
            iconArray = menuData.menuViewImage(self)
            numberArray = menuData.menuViewNumber(self)
        }
    }
    
    fileprivate func collectionCell(_ cell: HomePageMenuCell, cellForItemAt indexPath: IndexPath) {
        cell.nameLabel.text = nameArray[indexPath.row]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomePageMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePageMenuCell.identifire, for: indexPath) as! HomePageMenuCell
        cell.backgroundColor = UIColor.orange
        collectionCell(cell, cellForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.menuView(self, didSelectItemAt: indexPath)
        let cell = collectionView.cellForItem(at: indexPath)
        menuDelegate?.menuView(self, collectionCell: cell!, ItemAt: indexPath)
    }
    
}


