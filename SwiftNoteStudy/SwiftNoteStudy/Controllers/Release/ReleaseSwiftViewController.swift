//
//  ReleaseSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

struct SkillsStruct {
    var Experience: CGFloat
    var SilverTicket: CGFloat
}

import UIKit

class ReleaseSwiftViewController: BaseSwiftViewController {
    let 流火 = SkillsStruct(Experience: 31629583, SilverTicket: 2665625)
    let 羿射九日 = SkillsStruct(Experience: 1427464432, SilverTicket: 71318813)
    let 蝎尾 = SkillsStruct(Experience: 217590615, SilverTicket: 16296732)
    let 凝霜 = SkillsStruct(Experience: 35771551, SilverTicket: 3069074)
    let 心玄 = SkillsStruct(Experience: 877267640, SilverTicket: 47261438)
    let 千钧 = SkillsStruct(Experience: 314351944, SilverTicket: 22196311)
    let 满引弓 = SkillsStruct(Experience: 3542492809, SilverTicket: 121918395)
    let 石破天惊 = SkillsStruct(Experience: 3701219735, SilverTicket: 102901356)

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //经验
        let experience = 流火.Experience + 羿射九日.Experience + 蝎尾.Experience + 凝霜.Experience + 心玄.Experience + 千钧.Experience + 满引弓.Experience + 石破天惊.Experience;
        //银票
        let silverTicket = 流火.SilverTicket + 羿射九日.SilverTicket + 蝎尾.SilverTicket + 凝霜.SilverTicket + 心玄.SilverTicket + 千钧.SilverTicket + 满引弓.SilverTicket + 石破天惊.SilverTicket;
        
//        经验：101 4778 8309.0------ 银票：3 8762 7744.0
        
        
        
        print("经验：\(experience)------ 银票：\(silverTicket)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //归并排序
    func mergeSort(_ array: [Int]) -> [Int] {
        var helper = Array(repeating: 0, count: array.count), array = array
        mergeSort(&array, &helper, 0 , array.count - 1)
        return array
    }
    
    func mergeSort(_ array: inout [Int], _ helper: inout [Int], _ low: Int, _ high: Int) {
        
    }
    
}


