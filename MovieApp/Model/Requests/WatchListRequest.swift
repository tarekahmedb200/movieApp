//
//  WatchListRequest.swift
//  MovieApp
//
//  Created by lapshop on 6/7/21.
//

import Foundation

struct WatchListRequest : Codable {
    var mediaType : String
    var mediaID : Int
    var watchlist : Bool
    
    
    enum CodingKeys : String , CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case watchlist
    }
    
}
