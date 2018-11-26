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
    
    public var number: Int = 0 {
        didSet {
            if number == 0 {
                numberLabel.isHidden = true
            }else {
                numberLabel.isHidden = false
                numberLabel.text = "\(number)"
                switch number {
                case 0..<10: numberWidth = 18
                case 10..<100: numberWidth = 22
                default: numberWidth = 27; numberLabel.text = "99+"
                }
            }
        }
    }
    
    public var cellStruct: MenuCellStruct = MenuCellStruct() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var nameLabel: UILabel!
    public var iconImage: UIImageView!
    fileprivate var numberLabel: UILabel!
    fileprivate var numberWidth: CGFloat = 18
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initView() {
        iconImage = UIImageView()
        iconImage.backgroundColor = UIColor.red
        iconImage.contentMode = .scaleAspectFill
        iconImage.clipsToBounds = true
        contentView.addSubview(iconImage)
        
        nameLabel = UILabel()
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textAlignment = .center
        contentView.addSubview(nameLabel)
        
        numberLabel = UILabel()
        numberLabel.textColor = UIColor.white
        numberLabel.backgroundColor = UIColor.blue
        numberLabel.layer.cornerRadius = 9
        numberLabel.font = UIFont.systemFont(ofSize: 12)
        numberLabel.clipsToBounds = true
        numberLabel.isHidden = true
        numberLabel.textAlignment = .center
        contentView.addSubview(numberLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImage.frame = CGRect(x: (bounds.width - cellStruct.iconImageHeight)/2, y: cellStruct.iconImageTop, width: cellStruct.iconImageHeight, height: cellStruct.iconImageHeight)
        
        let titleHeight = (bounds.height - cellStruct.iconImageHeight - cellStruct.iconImageTop - cellStruct.titleTopHeight)
        nameLabel.frame = CGRect(x: 5, y: iconImage.frame.maxY + cellStruct.titleTopHeight, width: bounds.width - 10, height: titleHeight)
        nameLabel.font = cellStruct.titleFont
        nameLabel.textColor = cellStruct.titleColor
        
        let numberTop = cellStruct.iconImageTop > 9 ? iconImage.frame.minY - 9 : 0
        numberLabel.frame = CGRect(x: iconImage.frame.maxX - 9, y: numberTop, width: numberWidth, height: 18)
        
    }
    
}
