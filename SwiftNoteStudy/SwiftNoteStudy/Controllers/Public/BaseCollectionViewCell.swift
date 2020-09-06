//
//  BaseCollectionViewCell.swift
//  SwiftNoteStudy
//
//  Created by L j on 2020/9/6.
//  Copyright © 2020 lj. All rights reserved.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "名称"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initView() {
        
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        let color1 = UIColor(red: 255.0/255.0, green: 70.0/255.0, blue: 93.0/255.0, alpha: 1.0).cgColor
        let color2 = UIColor(red: 251.0/255.0, green: 108.0/255.0, blue: 42.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [color1 ,color2]
        gradientLayer.locations = [0.1, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        backView.layer.insertSublayer(gradientLayer, above: gradientLayer)
        contentView.addSubview(backView)
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
}
