//
//  Protocols.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/25.
//  Copyright © 2018年 lj. All rights reserved.
//

import Foundation

// MARK:- Enum
enum LoginResult {
    case invalidatedUserName
    case invalidatedPassword
    case success
    case failure
}

// MARK:- Protocol
protocol ValidatedModelType {
    func validatedUserName(_ username: String) -> String
    func validatedPassword(_ password: String) -> String
    func combine(_ username: String, _ password: String) -> String
    func login(_ username: String, _ password: String) -> LoginResult
}









