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


class HomeSwiftViewController: BaseSwiftViewController, HomePageMenuDataSource, HomePageMenuDelegate {

    var menuView: HomePageMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        menuView = HomePageMenuView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 70))
        menuView.isAdaptiveHeight = true
        menuView.column = 2
    
//        menuView.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        //        menuView.itemSizeHeight = 100
        //        menuView.interitemSpacing = 10
        //        menuView.lineSpacing = 10
        //        menuView.
        
        menuView.menuDataSource = self
        menuView.menuDelegate = self
        view.addSubview(menuView)
        
//        let array = getAllFilePath("‎⁨Desktop/svn/BlackFish")
//        print(array)
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .desktopDirectory, in: .userDomainMask)
        let url = urlForDocument[0]
        craeteFile(name: "test.txt", fileBaseUrl: url)
    }
    
    func craeteFile(name: String, fileBaseUrl: URL) {
        let manager = FileManager.default
        let file = fileBaseUrl.appendingPathComponent(name)
        print("文件：\(file)")
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            // 在文件中随便写入一些内容
            let data = Data(base64Encoded: "adadswewew", options: .ignoreUnknownCharacters)
            let createSuccess = manager.createFile(atPath: file.path, contents: data, attributes: nil)
            print("文件创建结果：\(createSuccess)")
        }
    }
    
    func menuViewName(_ menuView: HomePageMenuView) -> [String] {
        return ["菜单1","菜单2","菜单3","菜单4","菜单5","菜单2","菜单3","菜单4","菜单5"]
    }
    
    func menuViewImage(_ menuView: HomePageMenuView) -> [String] {
        return ["菜单1","菜单2","菜单3","菜单4","菜单5","菜单2","菜单3","菜单4","菜单5"]
    }
    
    func menuView(_ menuView: HomePageMenuView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.item)")
        
    }
    
    func menuView(_ menuView: HomePageMenuView, collectionCell: UICollectionViewCell, ItemAt indexPath: IndexPath) {
        let cell = collectionCell as! HomePageMenuCell
        print("\(indexPath.item)")
        print(cell)
    }
    
    func getAllFilePath(_ dirPath: String) -> [String]? {
        var filePaths = [String]()
        
        do {
            let array = try FileManager.default.contentsOfDirectory(atPath: dirPath)
            
            for fileName in array {
                var isDir: ObjCBool = true
                
                let fullPath = "\(dirPath)/\(fileName)"
                
                if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir) {
                    if !isDir.boolValue {
                        filePaths.append(fullPath)
                    }
                }
            }
            
        } catch let error as NSError {
            print("get file path error: \(error)")
        }
        
        return filePaths;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
