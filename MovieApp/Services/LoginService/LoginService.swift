//
//  LoginService.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation

class LoginService {
    
    static func login(with userName:String,and password:String,completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.requestToken { (success, error) in
            if success {
                LoginService.handleCreateRequestTokenResponse(userName: userName,password:password,completion: completion)
            }else {
                completion(false,error)
            }
        }
    }
    
    
    static func loginAsGuest(completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.requestToken { (success, error) in
            if success {
                LoginService.handleCreateRequestTokenResponseForGuest(completion: completion)
            }else {
                completion(false,error)
            }
        }
    }
    
    
    static func logout(completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.deleteSessionID { (success, error) in
            if success {
                completion(true,nil)
            }else {
                completion(false,error)
        }
        }
    }
    
}
