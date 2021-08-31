//
//  LogoutRequest.swift
//  MovieApp
//
//  Created by lapshop on 8/31/21.
//

import Foundation
struct LogoutRequest : Codable {
    var sessionID : String
    
    
    enum CodingKeys : String , CodingKey {
        case sessionID = "session_id"
    }
    
}
