//
//  SignInViewModel.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/27.
//

import Foundation

class SignInViewModel {
    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserForSignIn(completion: @escaping () -> Void) {
        print("clicked")
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            guard let userData = userData else {
                return
            }
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            completion()
        }
    }
}
