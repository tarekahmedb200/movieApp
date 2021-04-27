//
//  Movie.swift
//  MovieApp
//
//  Created by lapshop on 4/27/21.
//

import Foundation

struct Movie : Codable {
    
    var id : Int
    var posterPath : String?
    var adult: Bool
    var overview : String
    var releaseDate : String
    var genresIDS : [Int]
    var title : String
    var backdropPath : String?
    var popularity : Double
    
    enum CodingKeys : String , CodingKey {
        case id
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genresIDS = "genre_ids"
        case title
        case backdropPath = "backdrop_path"
        case popularity
    }
    
}


