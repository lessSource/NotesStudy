//
//  HomeSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/7.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import SnapKit

class HomeSwiftViewController: BaseSwiftViewController {
    
    fileprivate var redView: UIView = {
        let redView = UIView(frame: CGRect(x: 100, y: 100, width: 150, height: 40))
        redView.backgroundColor = UIColor.red
        return redView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        guard let topViewController = App.topViewController() else {
            return
        }
        
        print(topViewController)
        
//        let type_column = Expression<Int>("type")
//        let time_column = Expression<Int>("time")
//        let year_column = Expression<Int>("year")
//        let month_column = Expression<Int>("month")
//        let week_column = Expression<Int>("week")
//        let day_column = Expression<Int>("day")
//        let value_column = Expression<Double>("value")
//        let tag_column = Expression<String>("tag")
//        let detail_column = Expression<String>("detail")
        
        
        var dic: Dictionary<String, Any> = Dictionary()
        dic.updateValue(7, forKey: "type")
        dic.updateValue(6, forKey: "time")
        dic.updateValue(5, forKey: "year")
        dic.updateValue(4, forKey: "month")
        dic.updateValue(3, forKey: "week")
        dic.updateValue(2, forKey: "day")
        dic.updateValue(23.2, forKey: "value")
        dic.updateValue("dsdsds", forKey: "tag")
        dic.updateValue("ddasdas", forKey: "detail")
        
        
        for _ in 0..<100000 {
//            UserSQLite.sharedInstance.insert(item: dic)
        }
//        UserSQLite.sharedInstance.insert(item: dic)

//        UserSQLite.sharedInstance.delete(filter: type_column = 2)
//        print(UserSQLite.sharedInstance.search(select: [type_column], order: [type_column]))
    }

    
//    public static String parseDate(String dateStr) throws ParseException {
//    DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm:ss.SSSZ");
//    Date result;
//    result = df.parse(dateStr);
//    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//    sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
//    return sdf.format(result);
//    }
    
    func ddddd() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        MBAlertUtil.alertManager.showPromptInfo("ddddd", in: view)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
//            MBAlertUtil.alertManager.showPromptInfo("ddddd")
//        }
//        MBAlertUtil.alertManager.showPromptInfo("ddd")
//        MBAlertUtil.alertManager.showPromptInfo("ddddd")
        MBAlertUtil.alertManager.showPromptInfo("ddddd2")

        MBAlertUtil.alertManager.showLoadingMessage()
        MBAlertUtil.alertManager.hiddenLoading()
        MBAlertUtil.alertManager.hiddenLoading()
        MBAlertUtil.alertManager.hiddenLoading()
        MBAlertUtil.alertManager.showLoadingMessage("22222")
        MBAlertUtil.alertManager.showPromptInfo("ddddd")

        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            MBAlertUtil.alertManager.hiddenLoading()
            MBAlertUtil.alertManager.showLoadingMessage()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let _ = DropDownMenuView(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenHeight), clickView: redView)
    }
}



