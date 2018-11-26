//
//  SelectMediaView.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/20.
//  Copyright © 2018 lj. All rights reserved.
//

protocol SelectMediaViewDelegate: NSObjectProtocol {
    /** 添加图片 */
    func mediaView(_ mediaView: SelectMediaView, addForItemAt item: Int)
    /** 删除图片 */
    func mediaView(_ mediaView: SelectMediaView, deleteForItemAt item: Int)
    /** 选中图片 */
    func mediaView(_ mediaView: SelectMediaView, didSelectForItemAt item: Int)
    /** 数据 */
    func mediaViewImage(_ mediaView: SelectMediaView) -> [String]
}

extension SelectMediaViewDelegate {
    func mediaView(_ mediaView: SelectMediaView, addForItemAt item: Int) { }
    func mediaView(_ mediaView: SelectMediaView, deleteForItemAt item: Int) { }
    func mediaView(_ mediaView: SelectMediaView, didSelectForItemAt item: Int) { }
}


import UIKit

class SelectMediaView: UICollectionView {
    weak var mediaDelegate: SelectMediaViewDelegate?
    /** 最大数量 */
    public var maxImageCount: Int = 6
    /** 横向数量 默认itemSize 有效 */
    public var column: Int = 4
    /** itemHeight */
    public var itemSizeHeight: CGFloat = 70
    /** 是否自适应高度 */
    public var isAdaptiveHeight: Bool = false
    /** 是否可编辑 */
    public var isEditor: Bool = true
    /** 是否支持3D touch */
    public var is3DTouch: Bool = false
    /** 横向间距 */
    public var interitemSpacing: CGFloat = 1 {
        didSet {
            flowLayout.minimumInteritemSpacing = interitemSpacing
        }
    }
    /** 纵向间距 */
    public var lineSpace: CGFloat = 1 {
        didSet {
            flowLayout.minimumLineSpacing = lineSpace
        }
    }
    /** 周边间距 */
    public var sectionInset: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            flowLayout.sectionInset = sectionInset
        }
    }
    /** 方向 */
    public var scrollDirection: ScrollDirection = .vertical {
        didSet {
            flowLayout.scrollDirection = scrollDirection
        }
    }
    
    
    fileprivate let CorrectNumber: CGFloat = 0.2
    fileprivate var flowLayout: UICollectionViewFlowLayout!
    fileprivate var imageArray: [String] = []
    fileprivate var itemSize: CGSize = CGSize.zero
    
    deinit {
        print("-----deinit----")
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
    
    // MARK:- initView
    fileprivate func initView() {
        self.delegate = self
        self.dataSource = self
//        if #available(iOS 11.0, *) {
//            self.dragDelegate = self
//        } else {
//            // Fallback on earlier versions
//        }
        self.alwaysBounceVertical = false
        self.alwaysBounceHorizontal = false
        flowLayout.minimumLineSpacing = lineSpace
        flowLayout.minimumInteritemSpacing = interitemSpacing
        flowLayout.scrollDirection = scrollDirection
        
        if #available(iOS 11.0, *) {
            self.dragInteractionEnabled = true
            self.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.register(SelectMediaCollectionViewCell.self, forCellWithReuseIdentifier: SelectMediaCollectionViewCell.identifire)
    }
    
    override func reloadData() {
        super.reloadData()
        let allWidth: CGFloat = frame.width - CGFloat((column - 1)) * interitemSpacing - CorrectNumber - sectionInset.left - sectionInset.right
        self.itemSize = CGSize(width: allWidth/CGFloat(column), height: itemSizeHeight)
        if let mediaDe = mediaDelegate {
            imageArray = mediaDe.mediaViewImage(self)
        }
        if imageArray.count == 0 { self.height = 0 }
        if isAdaptiveHeight {
            self.height = flowLayout.collectionViewContentSize.height
        }
    }
    
    
    fileprivate func collectionView(_ cell: SelectMediaCollectionViewCell, assignmentItemAt indexPath: IndexPath) {
        cell.buttonClick = { [weak self] in
            self?.mediaDelegate?.mediaView(self!, deleteForItemAt: indexPath.item)
        }
        
        if isEditor && imageArray.count != maxImageCount && indexPath.item == imageArray.count {
            cell.imageView.backgroundColor = UIColor.blue
            cell.deleteButton.isHidden = true
        }else {
            cell.imageView.image = UIImage(named: imageArray[indexPath.item])
            cell.deleteButton.isHidden = !isEditor
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SelectMediaView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(maxImageCount, imageArray.count + (isEditor ? 1 : 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectMediaCollectionViewCell.identifire, for: indexPath) as! SelectMediaCollectionViewCell
        self.collectionView(cell, assignmentItemAt: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditor && imageArray.count != maxImageCount && indexPath.item == imageArray.count {
            mediaDelegate?.mediaView(self, addForItemAt: indexPath.item)
        }else {
            mediaDelegate?.mediaView(self, didSelectForItemAt: indexPath.item)
        }
    }
    
}


//extension SelectMediaView: UICollectionViewDragDelegate {
//    @available(iOS 11.0, *)
//    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
////        let item = ["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"]
//        let item = "hp_pc_bacao"
//        let itemProvider = NSItemProvider(object: item as NSItemProviderWriting)
//        let dragItem = UIDragItem(itemProvider: itemProvider)
//        dragItem.localObject = item
//    }
//
////    itemsForBeginning
//
//}