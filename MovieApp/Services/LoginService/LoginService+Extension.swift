//
//  LoginService+Extension.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation


extension LoginService {
    
    
    static func handleCreateRequestTokenResponse(userName: String,password:String,completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.login(with: userName, and: password) { (success, error) in
            if success {
                handleLoginResponse(completion: completion)
            }else {
                completion(false,error)
            }
        }
    }
    
    static  func handleLoginResponse(completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.createSessionID { (success, error) in
            if success {
                completion(success,nil)
            }else {
                completion(false,error)
            }
        }
    }
    
    
    static func handleCreateRequestTokenResponseForGuest(completion:@escaping (Bool,Error?)-> Void) {
        MovieDBAPI.requestGuestSession { (success, error) in
            if  success {
                completion(success,nil)
            }else {
                completion(false,error)
            }
        }
    }
    
    
    
    
}
