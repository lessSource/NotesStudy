//
//  TestTestTableViewCell.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2019/3/31.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

class TestTestTableViewCell: UITableViewCell {

    @IBOutlet weak var conetnetHeight: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func testHeight(_ indexPath: IndexPath) {
        conetnetHeight.constant = CGFloat(84 * indexPath.row)
        
        for i in 0..<indexPath.row {
            let view: UIView = UIView()
            view.backgroundColor = UIColor.randomColor
            stackView.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.height.equalTo(84)
                make.right.left.equalToSuperview()
                make.top.equalTo(84 * i)
            }
        }
    }
    
}
