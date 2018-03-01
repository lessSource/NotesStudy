//
//  ViewModel.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/25.
//  Copyright © 2018年 lj. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ViewModel {
    let validatedLabel: Driver<String>
    let loginResult: Driver<LoginResult>
    
    init(username: Driver<String>, password: Driver<String>, loginTap: Driver<Void>, model: ValidatedModelType) {
        validatedLabel = Driver.combineLatest(username, password, resultSelector: {
            model.combine(model.validatedUserName($0), model.validatedPassword($1))
        })
        
        let usernameAndPassword = Driver.combineLatest(username, password) {
            ($0, $1)
        }
        loginResult = loginTap.withLatestFrom(usernameAndPassword).map({ (username, password) in
            model.login(username, password)
        })
    }
}
