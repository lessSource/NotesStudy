//
//  ShowImageViewController.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/19.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit

private let cellMargin: CGFloat = 20


class ShowImageViewController: UICollectionViewController {
    
    fileprivate var imageArray: [String] = []
    fileprivate var currentIndex: Int = 0
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ddd")
    }
    
    convenience init(imageArray: [String], currentIndex: Int) {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Constant.screenWidth + cellMargin, height: Constant.screenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        self.init(collectionViewLayout: layout)
        self.imageArray = imageArray
        self.currentIndex = currentIndex
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }
    
    fileprivate func layoutView() {
        collectionView?.frame = UIScreen.main.bounds
        collectionView?.width = Constant.screenWidth + cellMargin
        collectionView?.alwaysBounceHorizontal = true
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(ShowImageCollectionViewCell.self, forCellWithReuseIdentifier: ShowImageCollectionViewCell.identifire)
        collectionView?.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .left, animated: false)
    }
}


// MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension ShowImageViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowImageCollectionViewCell.identifire, for: indexPath) as! ShowImageCollectionViewCell
        cell.currentImage.image = UIImage(named: imageArray[currentIndex])
        cell.imageClick(action: { [weak self] (type) in
            self?.imageClick(cell, cellForItemAt: indexPath, type: type)
        })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let showImageCell = cell as! ShowImageCollectionViewCell
        showImageCell.scrollView.zoomScale = 1.0
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.width)
    }
    
    fileprivate func imageClick(_ cell: ShowImageCollectionViewCell, cellForItemAt indexPath: IndexPath, type: ShowImageCollectionViewCell.ActionEnum) {
        switch type {
        case .tap: self.dismiss(animated: true, completion: nil)
        case .long: break
        }
    }
    
//    fileprivate func alert
    
    
}
