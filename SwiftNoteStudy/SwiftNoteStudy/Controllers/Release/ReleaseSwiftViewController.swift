//
//  ReleaseSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa

//歌曲结构体
struct Music {
    let name: String //歌名
    let singer: String //演唱者
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension Music: CustomStringConvertible {
    var description: String {
        return "name：\(name) singer：\(singer)"
    }
}

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        ])
}



class ReleaseSwiftViewController: BaseSwiftViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight), style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(ReleaseTableViewCell.self, forCellReuseIdentifier: ReleaseTableViewCell.identifire)
        return tableView
    }()
    
    // 列表数据源
    let musicListViewModel = MusicListViewModel()
    
    // 负责对象销毁
    let disposeBag = DisposeBag()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: ReleaseTableViewCell.identifire, cellType: ReleaseTableViewCell.self)) { _, music, cell in
            cell.nameLabel.text = music.name
            cell.detailLabel.text = music.singer
        }.disposed(by: disposeBag)
        
        
//        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: ReleaseTableViewCell.identifire, cellType: ReleaseTableViewCell.self)) { _ ,_ ,_ in
//
//        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Music.self).subscribe { (music) in
            print("你选择的歌曲【\(music)】")
        }.disposed(by: disposeBag)
        
        
//        tableView.rx.
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ReleaseSwiftViewController.userDidTakeScreenshot), name: .UIApplicationUserDidTakeScreenshot, object: nil)

        tableView.placeholderShow(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    @objc func userDidTakeScreenshot() {
        // 当前屏幕的image
        let image = imageWithScrrnshot()
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 50, width: 320, height: 640))
        imageView.image = image
        view.addSubview(imageView)
    }

    // 获取当前屏幕图片
    func imageWithScrrnshot() -> UIImage? {
        let imageData = dataWithScreenshotInPNGFormat()
        return UIImage(data: imageData)
    }
    
    // 截取当前屏幕
    func dataWithScreenshotInPNGFormat() -> Data {
        var imageSize = CGSize.zero
        let screenSize = UIScreen.main.bounds.size
        let orientation = UIApplication.shared.statusBarOrientation
        if UIInterfaceOrientationIsPortrait(orientation) {
            imageSize = screenSize
        }else {
            imageSize = CGSize(width: screenSize.height, height: screenSize.width)
        }
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        for window in UIApplication.shared.windows {
            context?.saveGState()
            context?.translateBy(x: window.x, y: window.y)
            context?.concatenate(window.transform)
            context?.translateBy(x: -window.width * window.layer.anchorPoint.x, y: -window.height * window.layer.anchorPoint.y)

            if orientation == UIInterfaceOrientation.landscapeLeft {
                context?.rotate(by: CGFloat.pi/2)
                context?.translateBy(x: 0, y: -imageSize.width)
            }else if orientation == .landscapeRight {
                context?.rotate(by: -CGFloat.pi/2)
                context?.translateBy(x: -imageSize.height, y: 0)
            }else if orientation == .portraitUpsideDown {
                context?.rotate(by: -CGFloat.pi)
                context?.translateBy(x: -imageSize.width, y: -imageSize.height)
            }
            if window.responds(to: #selector(UIView.drawHierarchy(in:afterScreenUpdates:))) {
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }else {
                window.layer.render(in: context!)
            }
            context?.restoreGState()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImagePNGRepresentation(image!)!
        
    }
 */
    
}


extension ReleaseSwiftViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifire)
//        return cell!
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
