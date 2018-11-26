//
//  HomePageMenuView.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/2.
//  Copyright © 2018 less. All rights reserved.
//

import UIKit
import Kingfisher

protocol HomePageMenuDelegate: NSObjectProtocol {
    /** item点击 */
    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath)
    /** item点击 */
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell,didSelectItemAt indexPath: IndexPath)
    /** View高度 */
    func menuViewHeight(_ menuView: HomePageMenuView, viewHeight: CGFloat)
    /** 3D touch */
    func menuView(_ menuView: HomePageMenuView, previewingContext: UIViewControllerPreviewing, touchItemAt indexPath: IndexPath) -> UIViewController?
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
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell,didSelectItemAt indexPath: IndexPath) {}
    func menuViewHeight(_ menuView: HomePageMenuView, viewHeight: CGFloat) {}
    func menuView(_ menuView: HomePageMenuView, previewingContext: UIViewControllerPreviewing, touchItemAt indexPath: IndexPath) -> UIViewController? {
        return nil
    }
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
    /** 横向数量 默认itemSize 有效 */
    public var column: Int = 4
    /** view最大高度 isAdaptiveHeight = true 生效 */
    public var memuHeight: CGFloat = (Constant.screenHeight - Constant.bottomBarHeight - Constant.navbarAndStatusBar - 50)
    
    /** 是否自适应高度 */
    public var isAdaptiveHeight: Bool = false
    
    /** 是否支持3D touch */
    public var is3DTouch: Bool = false
    
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
    /** 周边间隔 */
    public var sectionInset: UIEdgeInsets = UIEdgeInsets() {
        didSet {
            flowLayout.sectionInset = sectionInset
        }
    }
    /** cell属性 */
    public var cellStruct: MenuCellStruct = MenuCellStruct()
    /** itemHeight */
    public var itemSizeHeight: CGFloat = 70
    
    fileprivate let CorrectNumber: CGFloat = 0.2
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    fileprivate var itemSize: CGSize = CGSize.zero
    fileprivate var nameArray = [String]()
    fileprivate var iconArray = [String]()
    fileprivate var numberArray = [Int]()

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
        initView()
    }
    
    fileprivate func initView() {
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
        
        let allWidth: CGFloat = frame.width - CGFloat((column - 1)) * interitemSpacing - CorrectNumber - sectionInset.left - sectionInset.right
        self.itemSize = CGSize(width: allWidth/CGFloat(column), height: itemSizeHeight)
        if let menuData = menuDataSource {
            nameArray = menuData.menuViewName(self)
            iconArray = menuData.menuViewImage(self)
            numberArray = menuData.menuViewNumber(self)
        }
        menuDelegate?.menuViewHeight(self, viewHeight: flowLayout.collectionViewContentSize.height)
        if nameArray.count == 0 { frame.size.height = 0 }
        assert(nameArray.count == iconArray.count, "The name is not equal to the number of images")
        if isAdaptiveHeight {
            self.height = min(memuHeight, flowLayout.collectionViewContentSize.height)
        }
    }
    
    fileprivate func collectionCell(_ cell: HomePageMenuCell, cellForItemAt indexPath: IndexPath) {
        cell.nameLabel.text = nameArray[indexPath.item]
        cell.cellStruct = cellStruct
        if nameArray.count == numberArray.count {
            cell.number = numberArray[indexPath.item]
        }
        let imageStr = iconArray[indexPath.item]
        if imageStr.hasPrefix("http://") {
            if let url = URL(string: imageStr) {
                cell.iconImage.kf.setImage(with: ImageResource(downloadURL: url), placeholder: UIImage(named: "ddd"))
            }
        }else {
            cell.iconImage.image = UIImage(named: imageStr)
        }
        
    }
    
    fileprivate func registerForPreviewingView(_ cell: HomePageMenuCell, cellForItemAt indexPath: IndexPath) {
        if traitCollection.forceTouchCapability == .available && is3DTouch {
            // 支持3D Touch
            // 注册Peek & Pop功能
            self.viewController()?.registerForPreviewing(with: self, sourceView: cell)
        }
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
        collectionCell(cell, cellForItemAt: indexPath)
        registerForPreviewingView(cell, cellForItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let indexSize = menuDataSource?.menuViewSize(self, forItemAt: indexPath)
        if indexSize!.equalTo(CGSize.zero) {
            return itemSize
        }else {
            return indexSize!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.menuView(self, didSelectItemAt: indexPath)
        let cell = collectionView.cellForItem(at: indexPath)
        menuDelegate?.menuView(self, collectionCell: cell!, didSelectItemAt: indexPath)
    }
    
}

extension HomePageMenuView: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let indexPath = self.indexPath(for: previewingContext.sourceView as! UICollectionViewCell)
        if let index = indexPath {
            return menuDelegate?.menuView(self, previewingContext: previewingContext, touchItemAt: index)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.viewController()?.show(viewControllerToCommit, sender: self)
    }
}

struct MenuCellStruct {
    /** 图片距上距离 */
    var iconImageTop: CGFloat = 5
    /** 图标宽高 */
    var iconImageHeight: CGFloat = 40
    /** 文字距图片距离 */
    var titleTopHeight: CGFloat = 5
    /** 文字大小 */
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14)
    /** 文字颜色 */
    var titleColor: UIColor = UIColor.black
}
