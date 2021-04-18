//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    private var viewState = BehaviorRelay<state>(value: .none)
    
    var stateObservable : Observable<state>   {
        return viewState.asObservable()
    }
    
    
    enum state {
        case none
        case loginSucceeded
        case loginFailed(errorMessage:String)
    }
    
    enum action {
        case clickLoginButton(userName:String,password:String)
        case clickEnterAsGuestButton
    }
    
    func onAction(action:action)   {
        switch action {
        case .clickLoginButton(let userName,let  password):
            login(with: userName, and: password)
            break
        case .clickEnterAsGuestButton:
            loginAsGuest()
            break
        }
    }
    
    
    private func login(with userName : String ,and password : String) {
        
        LoginService.login(with: userName, and: password) { (success, error) in
            if success {
                self.viewState.accept(.loginSucceeded)
            }else {
                self.viewState.accept(.loginFailed(errorMessage: error?.localizedDescription ?? "unKnown"))
            }
        }
    }
    
    private func loginAsGuest() {
        
        LoginService.loginAsGuest { (success, error) in
            if success {
                self.viewState.accept(.loginSucceeded)
            }else {
                self.viewState.accept(.loginFailed(errorMessage: error?.localizedDescription ?? "unKnown"))
            }
        }
    }

    
    
}
