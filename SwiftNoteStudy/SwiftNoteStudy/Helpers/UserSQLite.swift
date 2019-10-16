//
//  UserSQLite.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/3/11.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit
//import SQLite

//let type_column = Expression<Int>("type")
//let time_column = Expression<Int>("time")
//let year_column = Expression<Int>("year")
//let month_column = Expression<Int>("month")
//let week_column = Expression<Int>("week")
//let day_column = Expression<Int>("day")
//let value_column = Expression<Double>("value")
//let tag_column = Expression<String>("tag")
//let detail_column = Expression<String>("detail")
//let id_column = rowid


class UserSQLite {
    
//    static let sharedInstance = UserSQLite()
//    
//    private init() { }
//    
//    private lazy var db: Connection = {
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//        let db0 = try! Connection("\(path)/db.sqlite")
//        print(path)
//        db0.busyTimeout = 5.0
//        return db0
//    }()
//    
//    private lazy var table: Table = {
//        let table0 = Table("records")
//        try! db.run(table0.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (builder) in
//            builder.column(type_column)
//            builder.column(time_column)
//            builder.column(year_column)
//            builder.column(month_column)
//            builder.column(week_column)
//            builder.column(day_column)
//            builder.column(value_column)
//            builder.column(tag_column)
//            builder.column(detail_column)
//        }))
//        return table0
//    }()
//    
//    // 增
//    func insert(item: Dictionary<String, Any>) {
//        let insert = table.insert(type_column <- item["type"] as! Int,time_column <- item["time"] as! Int,year_column <- item["year"] as! Int,month_column <- item["month"] as! Int,week_column <- item["week"] as! Int,day_column <- item["day"] as! Int,value_column <- item["value"] as! Double,tag_column <- item["tag"] as! String,detail_column <- item["detail"] as! String)
//        if let rowId = try? db.run(insert) {
//            print("插入成功：\(rowId)")
//        }else {
//            print("插入失败")
//        }
//    }
//    
//    // 删单条
//    func delete(id: Int64) {
//        delete(filter: rowid == id)
//    }
//    
//    // 根据条件删除
//    func delete(filter: Expression<Bool>? = nil) {
//        var query = table
//        if let f = filter {
//            query = query.filter(f)
//        }
//        if let count = try? db.run(query.delete()) {
//            print("删除的条数为：\(count)")
//        }else {
//            print("删除失败")
//        }
//    }
//    
//    // 改
//    func update(id: Int64, item: Dictionary<String, Any>) {
//        let update = table.filter(rowid == id)
//        if let count = try? db.run(update.update(value_column <- item["value"] as! Double, tag_column <- item["tag"] as! String, detail_column <- item["detail"] as! String)) {
//            print("修改的结果为：\(count == 1)")
//        }else {
//            print("修改失败")
//        }
//    }
//    
//    // 查
//    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [rowid, type_column, time_column, value_column, tag_column, detail_column], order: [Expressible] = [time_column.desc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
//        var query = table.select(select).order(order)
//        if let f = filter {
//            query = query.filter(f)
//        }
//        if let l = limit {
//            if let o = offset {
//                query = query.limit(l, offset: o)
//            }else {
//                query = query.limit(l)
//            }
//        }
//        let result = try! db.prepare(query)
//        return Array(result)
//    }
}
