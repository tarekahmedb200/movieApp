//
//  requestSessionIDResponse.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation

struct RequestSessionIDResponse : Codable {
    var success : Bool
    var sessionID : String
    
    enum CodingKeys : String , CodingKey {
        case success
        case sessionID = "session_id"
    }
}
