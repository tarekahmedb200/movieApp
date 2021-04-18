//
//  RequestGuestSessionResponse.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation

struct RequestGuestSessionResponse : Codable {
    var success : Bool
    var expiresAt : String
    var guestSessionID : String
    
    enum CodingKeys : String , CodingKey {
        case success
        case expiresAt = "expires_at"
        case guestSessionID = "guest_session_id"
    }
    
}
