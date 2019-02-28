//
//  PublicMineViewController.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/2/28.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

class PublicMineViewController: BaseSwiftViewController {

    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    fileprivate lazy var headImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: -Constant.statusHeight, width: Constant.screenWidth, height: Constant.screenHeight/3))
        imageView.image = UIImage(named: "headImage")?.gaussianBlur(0.3)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0.0, alpha: 0.8)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "个人中心"
        setUpUI()
    }

    // MARK:- setUpUI
    fileprivate func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(headImage)
        
        let roundView: UIView = UIView(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
        roundView.layer.cornerRadius = 20
        roundView.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        roundView.layer.borderColor = UIColor.green.cgColor
        roundView.layer.borderWidth = Constant.lineHeight
        
        roundView.layer.shadowOffset = CGSize(width: 1, height: 1)
        roundView.layer.shadowColor = UIColor.white.cgColor
        roundView.layer.shadowRadius = 5
        roundView.layer.shadowOpacity = 5
        
        headImage.addSubview(roundView)
        

        
    }
    
    
    
}
