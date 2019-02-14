//
//  CacheModel.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/2/14.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit

class CacheModel: NSObject, NSCoding {
    var token: String = ""
    
    override init() {
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        token = aDecoder.decodeObject(forKey: "token") as! String
    }
}


class CacheObject {
    static let sharedInstance = CacheObject()
    
    public var cacheModel: CacheModel = CacheModel()
    
    
    
//    public var cacheModel: CacheModel {
//        if let model = NSKeyedUnarchiver.unarchiveObject(withFile: getPath()) as? CacheModel {
//            return model
//        }else {
//            return CacheModel()
//        }
//    }
    
    private init() { }
}

extension CacheObject {
    public func getPath() -> String {
        let pathArray = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let path  = pathArray[0]
        let disPath = "\(path)/CacheObject.data"
        return disPath
    }

    public func save() {
        NSKeyedArchiver.archiveRootObject(cacheModel, toFile: getPath())
    }
    
    public func reset() {
        cacheModel = CacheModel()
        save()
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: getPath())
        } catch {
            print("remove false")
        }
    }
    
//    public func getData() -> CacheModel {
//        if let model = NSKeyedUnarchiver.unarchiveObject(withFile: getPath()) as? CacheModel {
//            return model
//        }else {
//            return cacheModel
//        }
//    }
}

