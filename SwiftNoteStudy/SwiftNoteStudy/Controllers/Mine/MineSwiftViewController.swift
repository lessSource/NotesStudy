//
//  MineSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import RxSwift

class MineSwiftViewController: BaseSwiftViewController {

    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight - Constant.navbarAndStatusBar), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 40
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.‘
        navigationItem.title = "我的"
        view.addSubview(tableView)
        tableView.register(UINib(nibName: "TestTestTableViewCell", bundle: nil), forCellReuseIdentifier: TestTestTableViewCell.identifire)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        pushAndHideTabbar(PublicMineViewController())
    }

}

extension MineSwiftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTestTableViewCell = tableView.dequeueReusableCell(withIdentifier: TestTestTableViewCell.identifire) as! TestTestTableViewCell
        cell.testHeight(indexPath)
        return cell
    }
    
    
}
