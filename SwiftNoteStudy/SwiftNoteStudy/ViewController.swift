//
//  ViewController.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

enum CardColorEnum {
    /** ♠️ */
    case black
    /** ♥️ */
    case red
    /** ♣️ */
    case mei
    /** ♦️ */
    case party
    /** 🃏 */
    case wang
    /** 大王 */
    case king
}

struct CardStruct {
    /** 牌大小 */
    var number: Int = 0
    /** 牌花色 */
    var color: CardColorEnum = .black
    /** size */
    var size: CGSize = CGSize.zero
    /** point */
    var point: CGPoint = CGPoint.zero
    
}

