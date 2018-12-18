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
//        var x: Int64 = 0
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


class HomeSwiftViewController: BaseSwiftViewController, SelectMediaViewDelegate, ShowImageProtocol, UIViewControllerTransitioningDelegate {
    

    var menuView: HomePageMenuView!
    var mediaView: SelectMediaView!

    private var delegate: ModelAnimationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//
//        menuView = HomePageMenuView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 70))
//        menuView.isAdaptiveHeight = true
//        menuView.column = 5
//
////        menuView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
//        //        menuView.itemSizeHeight = 100
//        //        menuView.interitemSpacing = 10
//        //        menuView.lineSpacing = 10
//        //        menuView.
//
//        menuView.menuDataSource = self
//        menuView.menuDelegate = self
//        view.addSubview(menuView)
        
        /*
        mediaView = SelectMediaView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 70))
//        mediaView.isEditor = false
        mediaView.isAdaptiveHeight = true
        mediaView.mediaDelegate = self
        mediaView.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15)
        mediaView.interitemSpacing = 5
        mediaView.lineSpace = 5
        view.addSubview(mediaView)
 */

    }
    
    func mediaViewImage(_ mediaView: SelectMediaView) -> [String] {
        return ["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"]
    }
    
    func mediaView(_ mediaView: SelectMediaView, didSelectForItemAt item: Int) {
//        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: item)
        let cell = mediaView.cellForItem(at: IndexPath(item: item, section: 0)) as! SelectMediaCollectionViewCell
        delegate = ModelAnimationDelegate(originalView: cell.imageView)
        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: item, delegate: delegate!)
    }
    
//    func menuViewName(_ menuView: HomePageMenuView) -> [String] {
//        return ["菜单1","菜单2","菜单3","菜单4","菜单5","菜单2","菜单3","菜单4","菜单5"]
//    }
//
//    func menuViewImage(_ menuView: HomePageMenuView) -> [String] {
//        return ["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","hp_pc_bacao","","hp_pc_bacao","hp_pc_bacao"]
//    }
//
//    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath) {
//        print("\(indexPath.item)")
////        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: 0)
////        showImages(["hp_pc_bacao","hp_pc_bacao"], currentIndex: 0, delegate: ModelAnimationDelegate(originalView: <#T##UIImageView#>))
//
//    }
    
//    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell, ItemAt indexPath: IndexPath) {
//        let cell = collectionCell as! HomePageMenuCell
//        delegate = ModelAnimationDelegate.reset(delegate, imageView: cell.iconImage)
//
//        showImages(["hp_pc_bacao","hp_pc_bacao","hp_pc_bacao"], currentIndex: 0, delegate: delegate!)
//        print(cell)
//    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
