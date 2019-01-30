//
//  ReleaseTableViewCell.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/1/24.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit
import SnapKit

class ReleaseTableViewCell: UITableViewCell {

    public var nameLabel: UILabel!
    public var detailLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- initView
    fileprivate func initView() {
        nameLabel = UILabel()
        nameLabel.textColor = UIColor.red
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        
        detailLabel = UILabel()
        detailLabel.textColor = UIColor.blue
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(contentView.snp.right).offset(-15)
        }
    }
}
