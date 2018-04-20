//
//  LoginSwiftViewController.swift
//  NotesStudy
//
//  Created by Lj on 2018/2/25.
//  Copyright © 2018年 lj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginSwiftViewController: BaseSwiftViewController {

    let userNameTextFiled: UITextField = UITextField()
    let passwordTextFiled: UITextField = UITextField()
    let resultLabel: UILabel = UILabel()
    let loginButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: Alert
extension LoginSwiftViewController {
    func showAlertController(result: LoginResult) {
        let alertController = UIAlertController.init(title: "提示", message: result.description, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: MVC
extension LoginSwiftViewController: UITextFieldDelegate {
    
    enum textFieldTag: NSInteger {
        case username
        case password
    }
    
    func mvcFunc() {
        userNameTextFiled.tag = textFieldTag.username.rawValue
        passwordTextFiled.tag = textFieldTag.password.rawValue
        userNameTextFiled.delegate = self
        passwordTextFiled.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonAction(sender:)), for: .touchUpInside)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text
        var substring: String?
        if (range.length == 1 && string == "") {
            if let endIndex = text?.endIndex, let _ = text?.index(endIndex, offsetBy: -1) {
//                substring = text!.prefix(upTo: index)
            }
        }else {
            substring = text?.appending(string)
        }
        
        if let currentText = substring {
            switch textField.tag {
            case textFieldTag.username.rawValue:
                if let text = passwordTextFiled.text {
                    resultLabel.text = ValidatedModel.sharedInstance.combine(ValidatedModel.sharedInstance.validatedUserName(currentText), text)
                }
            case textFieldTag.password.rawValue:
                if let text = userNameTextFiled.text {
                    resultLabel.text = ValidatedModel.sharedInstance.combine(text, ValidatedModel.sharedInstance.validatedPassword(currentText))
                }
            default:
                break
            }
        }
        return true
    }
    
    @objc func loginButtonAction(sender: UIButton) {
        if let username = userNameTextFiled.text, let password = passwordTextFiled.text {
            let result = ValidatedModel.sharedInstance.login(username, password)
            self.showAlertController(result: result)
        }
    }
    
}


let disposeBag = DisposeBag()

private extension Reactive where Base: UILabel {
//    var combinedResult: UIBindingObserver<Base, String> {
//        return UIBindingObserver(UIElement: self.base, binding: {(label, string) in
//            label.text = string
//        })
//    }
    
}











