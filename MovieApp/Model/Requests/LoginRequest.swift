//
//  LoginRequest.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation


struct LoginRequest : Codable {
    var username : String
    var password : String
    var requestToken : String
    
    enum CodingKeys : String , CodingKey {
        case username = "username"
        case password = "password"
        case requestToken = "request_token"
    }
}
