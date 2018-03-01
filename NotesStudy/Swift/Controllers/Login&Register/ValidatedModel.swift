//
//  ValidatedModel.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/25.
//  Copyright © 2018年 lj. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

//Model
struct ValidatedModel: ValidatedModelType {
    
    static let sharedInstance = ValidatedModel()
    
    func validatedUserName(_ username: String) -> String {
        return username.uppercased()
    }
    
    func validatedPassword(_ password: String) -> String {
        return password.lowercased()
    }
    
    func combine(_ username: String, _ password: String) -> String {
        return username + password
    }
    
    func login(_ username: String, _ password: String) -> LoginResult {
        guard username.count > 3 else { return .invalidatedUserName }
        guard password.count > 3 else { return .invalidatedPassword }
        return (8...10).contains(username.count + password.count) ? .success : .failure
    }
}

extension LoginResult {
    var description: String {
        switch self {
        case .invalidatedUserName:
            return "无效的用户名"
        case .invalidatedPassword:
            return "无效的密码"
        case .success:
            return "登录成功"
        case .failure:
            return "登录失败"
        }
    }
    
}


