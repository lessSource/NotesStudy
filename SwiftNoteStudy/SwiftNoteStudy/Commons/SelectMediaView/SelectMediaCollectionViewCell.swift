//
//  SelectMediaCollectionViewCell.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/23.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit
import WebKit

class SelectMediaCollectionViewCell: UICollectionViewCell {
    typealias buttonBlock = () -> (Void)
    
    public var imageView: UIImageView!
    public var deleteButton: UIButton!
    public var buttonClick: buttonBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    //MARK:- initView
    func initView() {
        imageView = UIImageView()
//        imageView.backgroundColor = UIColor.red
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        deleteButton = UIButton()
        deleteButton.backgroundColor = UIColor.red
        deleteButton.addTarget(self, action: #selector(deleteButtonClick), for: .touchUpInside)
        contentView.addSubview(deleteButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        deleteButton.frame = CGRect(x: imageView.width - 20, y: imageView.x, width: 20, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Event
    @objc func deleteButtonClick() {
        if buttonClick != nil {
            buttonClick!()
        }
    }
    
}
