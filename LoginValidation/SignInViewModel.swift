//
//  ViewModel.swift
//  LoginValidation
//
//  Created by Андрей Колесников on 08.08.2022.
//

import Foundation
import RxSwift

class SignInViewModel {
    
    let loginTextFieldBehaviorSubject = BehaviorSubject<String>(value: "")
    let passwordTextFieldBehaviorSubject = BehaviorSubject<String>(value: "")
    
    func isValid() -> Observable<Bool> {
        let observable = Observable.combineLatest(loginTextFieldBehaviorSubject.asObservable(), passwordTextFieldBehaviorSubject.asObservable()).map { login, password in
            return login.count > 3 && password.count >= 8
        }
        
        return observable
    }
}
