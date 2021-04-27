//
//  MovieResult.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

struct MovieResult : Codable {
    
    var page  : Int
    var totalPages : Int
    var totalResults : Int
    var movies : [Movie]
    
    enum CodingKeys : String , CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
    
}
