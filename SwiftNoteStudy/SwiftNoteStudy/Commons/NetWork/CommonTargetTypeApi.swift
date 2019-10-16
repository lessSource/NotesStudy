//
//  CommonTargetTypeApi.swift
//  SwiftNoteStudy
//
//  Created by less on 2019/3/6.
//  Copyright © 2019 lj. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift
import HandyJSON

let BaseURL: String = ""

enum ApiManager {
    case login(username: String, password: String, token: String)
}

extension ApiManager: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL)!
    }
    
    // 请求路径
    var path: String {
        switch self {
        case .login(username: _, password: _, token: _):
            return "login/accountLogin"
        }
    }
    
    // 请求方式
    var method: Moya.Method {
        switch self {
        case .login(username: _, password: _, token: _):
        return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}


extension ObservableType where E == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapModel(T.self))
        }
    }
    
    
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String(data: data, encoding: .utf8)
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)!
    }
}



