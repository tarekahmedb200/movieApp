//
//  ErrorResponse.swift
//  MovieApp
//
//  Created by lapshop on 4/18/21.
//

import Foundation

struct ErrorResponse : Codable {
    var statusMessage : String
    var statusCode : Int

    enum CodingKeys : String , CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}

extension ErrorResponse : LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}


