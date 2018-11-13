//
//  HomePageMenuCell.swift
//  SwiftNoteStudy
//
//  Created by less on 2018/11/2.
//  Copyright © 2018 lj. All rights reserved.
//

import UIKit
import SnapKit

class HomePageMenuCell: UICollectionViewCell {
    
    public var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        viewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpUI() {
        nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = UIColor.black
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
    }
    
    fileprivate func viewLayout() {
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(5)
        }
    }
    
}
