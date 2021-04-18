//
//  createSessionRequest.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation
struct CreateSessionRequest : Codable {
    var requestToken : String
    
    enum CodingKeys : String , CodingKey {
        case requestToken = "request_token"
    }
    
}
