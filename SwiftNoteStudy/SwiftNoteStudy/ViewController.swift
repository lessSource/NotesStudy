//
//  ViewController.swift
//  SwiftNoteStudy
//
//  Created by Lj on 2018/4/17.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let nameLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        reverseWords(s: "who")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func _reverse<T>(_ chars: inout [T], _ start: Int, _ end: Int) {
        var start = start, end = end
        while start < end {
            swap(&chars, start, end)
            start += 1
            end -= 1
        }
    }
    
    fileprivate func swap<T>(_ chars: inout [T], _ p: Int, _ q: Int) {
        (chars[p], chars[q]) = (chars[q], chars[p]);
    }
    
    func reverseWords(s: String?) -> String? {
        guard let s = s else {
            return nil
        }
        var chars = Array(s.characters), start = 0
        _reverse(&chars, 0, chars.count - 1)
        
        for i in 0 ..< chars.count {
//            if i == chars.count - 1 || chars[i + 1] == "" {
//                _reverse(&chars, start, i)
//                start = i + 2
//            }
        }
        return String(chars)
        
    }
    


}

