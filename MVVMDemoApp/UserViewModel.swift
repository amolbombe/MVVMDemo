//
//  UserViewModel.swift
//  MVVMDemoApp
//
//  Created by Amol Bombe on 25/08/18.
//  Copyright © 2018 Amol. All rights reserved.
//

enum UserValidationState {
    case Valid
    case Invalid(String)
}

import Foundation
class UserViewModel {
    private var minUsernameLength = 8
    private var minPasswordLength = 6
    private var user = User()
    
    var username: Box<String> = Box(value: "")//String {
//        return user.username
//    }
    
    var password: String {
        return user.password
    }
}

extension UserViewModel {
    
    func updateUsername(username: String) {
        user.username = username
        self.username.value = username
        print("update \(username)")
    }
    
    func updatePassword(password: String) {
        user.password = password
    }
}

extension UserViewModel {
    func validate() -> UserValidationState {
        if user.username.isEmpty || user.password.isEmpty {
            return .Invalid("Invalid username and password")
        } else if user.username.count < minUsernameLength {
            return .Invalid("Invalid username")
        } else if user.password.count < minPasswordLength {
            return .Invalid("Invalid password")
        }
        return .Valid
    }
    
    func login(completion: (_ errorString: String?) -> Void) {
        if user.username == "amolbombe" && user.password == "amol123" {
            completion(nil)
        } else {
            completion("Invalid user")
        }
    }
}
